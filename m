From: Michal Ostrowski <mostrows@watson.ibm.com>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Tue, 10 Jan 2006 15:31:05 -0500
Message-ID: <1136925066.11717.605.camel@brick.watson.ibm.com>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
	 <1136849810.11717.518.camel@brick.watson.ibm.com>
	 <7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
	 <1136900174.11717.537.camel@brick.watson.ibm.com> <43C3CC4A.4030805@op5.se>
	 <1136910406.11717.579.camel@brick.watson.ibm.com>
	 <7vzmm36f1x.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0601102054200.27363@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 21:30:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwQ8J-0001Wl-Ik
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 21:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbWAJU3o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 15:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbWAJU3n
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 15:29:43 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:60076 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S932600AbWAJU3m
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 15:29:42 -0500
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com [129.34.20.41])
	by igw2.watson.ibm.com (8.12.11/8.13.1/8.13.1-2005-04-25 igw) with ESMTP id k0AKViut014218;
	Tue, 10 Jan 2006 15:31:44 -0500
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with ESMTP id k0AKTUk385922;
	Tue, 10 Jan 2006 15:29:31 -0500
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with ESMTP id k0AKTUu423562;
	Tue, 10 Jan 2006 15:29:30 -0500
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id k0ALQGeU030716;
	Tue, 10 Jan 2006 16:26:16 -0500
Received: from brick (brick.watson.ibm.com [9.2.216.48])
	by kitch0.watson.ibm.com (AIX5.1/8.11.6p2/8.11.0/03-06-2002) with ESMTP id k0AKTSm32202;
	Tue, 10 Jan 2006 15:29:28 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601102054200.27363@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.4.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14449>

On Tue, 2006-01-10 at 20:55 +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 10 Jan 2006, Junio C Hamano wrote:
> 
> > Michal Ostrowski <mostrows@watson.ibm.com> writes:
> > 
> > > git programs exec other git programs, but they also exec non-git
> > > programs.  I think it is not appropriate to change PATH (via
> > > prepend_to_path) because this may result in unexpected behavior when
> > > exec'ing non-git programs:
> > 
> > This is a valid concern.
> 
> Why? If what is prepended to PATH only contains git programs?
> 


If git is installed with prefix=/usr, then that won't be the case.


-- 
Michal Ostrowski <mostrows@watson.ibm.com>
