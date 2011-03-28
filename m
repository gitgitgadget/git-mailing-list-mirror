From: =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
Subject: Re: [PATCH] Remove "bashism" from contrib/thunderbird-patch-inline/appp.sh
Date: Mon, 28 Mar 2011 23:55:31 +0200
Message-ID: <4D9103D3.5010403@zoho.com>
References: <AANLkTin-USDnTxeKT_KOZW5kgC0vFXYbMNP9ct6fzbUC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 03:47:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4O1d-0007et-Oz
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 03:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295Ab1C2BrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 21:47:12 -0400
Received: from sender1.zohomail.com ([72.5.230.95]:50012 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab1C2BrL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 21:47:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type; 
  b=CkxBP8KDbsG1dUcU5DQR7EDz9wTPp3EUK66Xv1fqvoBEUFJEroyOtrSk1+QsHAWgK4NxqtgLgaSk
    rwN55PZEDZxtYVhwsFTvercq5ufXC2hqnd71Ls8PawjDl/5IYy+k  
Received: from [192.168.1.26] (61.Red-88-13-200.dynamicIP.rima-tde.net [88.13.200.61]) by mx.zohomail.com
	with SMTPS id 1301349064042690.1899682768741; Mon, 28 Mar 2011 14:51:04 -0700 (PDT)
User-Agent: Thunderbird
In-Reply-To: <AANLkTin-USDnTxeKT_KOZW5kgC0vFXYbMNP9ct6fzbUC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170213>

Maxin john wrote:
> Remove "bashism" and minor corrections for
> contrib/thunderbird-patch-inline/appp.sh
> 
> Signed-off-by: Maxin B. John <maxin@maxinbjohn.info>

This is wrong.

You are replacing bash with sh:
> -#!/bin/bash
> +#!/bin/sh

but the script still uses bash-specific syntax (aka. bashishms):
> +
>  PATCH=$(zenity --file-selection)
> 
>  if [ "$?" != "0" ] ; then

So with your change the script won't be able to run on systems which
don't have bash as /bin/sh
