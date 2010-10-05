From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: large files and low memory
Date: Tue, 05 Oct 2010 15:12:29 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010051510160.3107@xanadu.home>
References: <20101004092046.GA4382@nibiru.local>
 <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
 <4CAA1BEB.3050908@workspacewhiz.com>
 <AANLkTi=nzyRgiBL07f2oeyjdUc8XnaKbJEJ+k8_g9rQ1@mail.gmail.com>
 <20101005005902.GC2768@nibiru.local> <20101005074144.GA22564@nibiru.local>
 <AANLkTimHKyQhAzuh4Hsh7=bEet1T0mNRSMgiZkhWQwSN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: weigelt@metux.de, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 21:12:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3CwF-0007Rc-QD
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 21:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756591Ab0JETMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 15:12:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52407 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756399Ab0JETMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 15:12:30 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L9U001K300N5IB0@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 05 Oct 2010 15:12:23 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTimHKyQhAzuh4Hsh7=bEet1T0mNRSMgiZkhWQwSN@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158225>

On Tue, 5 Oct 2010, Nguyen Thai Ngoc Duy wrote:

> On Tue, Oct 5, 2010 at 2:41 PM, Enrico Weigelt <weigelt@metux.de> wrote:
> > * Enrico Weigelt <weigelt@metux.de> wrote:
> >
> > <snip>
> >
> > Found another possible bottleneck: git-commit seems to scan through
> > a lot of files. Shouldnt it just create a commit object from the
> > current index and update the head ?
> 
> You mean a lot of stat()? There is no way to avoid that unless you set
> assume-unchanged bits. Or you could use
> write-tree/commit-tree/update-ref directly.

Avoiding memory exhaustion is also going to help a lot as the stat() 
information will remain cached instead of requiring disk access.  Just a 
guess given $subject.


Nicolas
