From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] Teach read_tree_recursive() how to traverse into 
 submodules
Date: Mon, 19 Jan 2009 02:24:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901190218470.3586@pacific.mpi-cbg.de>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>  <1232275999-14852-2-git-send-email-hjemli@gmail.com>  <1232275999-14852-3-git-send-email-hjemli@gmail.com>  <alpine.DEB.1.00.0901181635290.3586@pacific.mpi-cbg.de> 
 <8c5c35580901180945u17a69140vff2736765ee6073@mail.gmail.com>  <alpine.DEB.1.00.0901181929220.3586@pacific.mpi-cbg.de>  <8c5c35580901181145x2e14fe0fq4ab0e94c13bad38a@mail.gmail.com>  <alpine.DEB.1.00.0901182201140.3586@pacific.mpi-cbg.de> 
 <8c5c35580901181331v5e54f82fxc6a042962ff1cd06@mail.gmail.com>  <alpine.DEB.1.00.0901182244310.3586@pacific.mpi-cbg.de> <8c5c35580901181446n3c36a345m5d8e78764a85c123@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 02:25:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOith-0006hq-SZ
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 02:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995AbZASBYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 20:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755968AbZASBYY
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 20:24:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:51012 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755919AbZASBYX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 20:24:23 -0500
Received: (qmail invoked by alias); 19 Jan 2009 01:24:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 19 Jan 2009 02:24:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194Ljlj85V4RtdQ05mDXg49bSmZ79CzM4yqYAAl3T
	47x0PrDSF541o4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <8c5c35580901181446n3c36a345m5d8e78764a85c123@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106298>

Hi,

On Sun, 18 Jan 2009, Lars Hjemli wrote:

> Sorry, but if your concern is whether to traverse a submodule in a bare 
> repo when the submodule isn't checked out (yeah, contradiction in 
> terms), I just don't see the point.

Obviously.

> For non-bare repositories the policy has always been to ignore
> submodules which isn't checked out, but for bare repositories there is
> no obvious way (for me, at least) to apply the same policy.

There is one:  we never traverse them in bare repositories.

Never.

You are introducing that contradicts that on purpose.  Which I do not 
like at all.

Sure, what you want is a nifty feature, but you'll have to do it right.

For example, your handling for bare repositories precludes everybody from 
specifying -- just for this particular call to git archive -- what 
submodules they want to include.  And you preclude anybody from excluding 
-- just for this particular call to git archive -- certain submodules 
whose commits just so happen to be present in the superproject.

For me, that is a sign of a bad user interface design.

Ciao,
Dscho

P.S.: if you still don't get the point, I will just shut up, until the 
question crops up, and redirect every person confused by that behavior to 
you.  Be prepared.
