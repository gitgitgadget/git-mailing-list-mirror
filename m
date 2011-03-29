From: =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
Subject: Re: [PATCH] Remove "bashism" from contrib/thunderbird-patch-inline/appp.sh
Date: Tue, 29 Mar 2011 02:16:00 +0200
Message-ID: <4D9124C0.8070003@zoho.com>
References: <AANLkTin-USDnTxeKT_KOZW5kgC0vFXYbMNP9ct6fzbUC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Lukas_Sandst?= =?ISO-8859-1?Q?r=F6m?= 
	<luksan@gmail.com>
To: Maxin john <maxin@maxinbjohn.info>
X-From: git-owner@vger.kernel.org Tue Mar 29 02:11:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4MX7-000356-Jm
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 02:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607Ab1C2ALg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 20:11:36 -0400
Received: from sender1.zohomail.com ([72.5.230.95]:58831 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab1C2ALf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 20:11:35 -0400
X-Greylist: delayed 8431 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Mar 2011 20:11:35 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type; 
  b=lx/AyTykp/GPTSw+08WAxyuSroHeD7ZcAyI4Qr+HGqgRP4frxopI4YrJRSIBtA5Ms7hL42YoTV3W
    Y971Z+NtpI3CNFs8yShpN8UcXsz97t4XAhc6ygbgX54ueL1CgDwb  
Received: from [192.168.1.26] (61.Red-88-13-200.dynamicIP.rima-tde.net [88.13.200.61]) by mx.zohomail.com
	with SMTPS id 130135749363591.4740672285136; Mon, 28 Mar 2011 17:11:33 -0700 (PDT)
User-Agent: Thunderbird
In-Reply-To: <AANLkTin-USDnTxeKT_KOZW5kgC0vFXYbMNP9ct6fzbUC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170208>

Maxin john wrote:
> > Remove "bashism" and minor corrections for
> > contrib/thunderbird-patch-inline/appp.sh
> >
> > Signed-off-by: Maxin B. John <maxin@maxinbjohn.info>
This is wrong.

You are replacing bash with sh:
> > -#!/bin/bash
> > +#!/bin/sh

but the script still uses bash-specific syntax (aka. bashishms):
> > +
> >  PATCH=$(zenity --file-selection)
> >
> >  if [ "$?" != "0" ] ; then

So with your change the script won't be able to run on systems which
don't have bash as /bin/sh

The standard equivalent of $( ) are `backticks`.
