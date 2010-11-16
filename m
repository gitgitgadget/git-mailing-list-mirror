From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/10] clean: support cleaning sparse checkout with -S
Date: Mon, 15 Nov 2010 21:07:28 -0600
Message-ID: <20101116030728.GB29358@burratino>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-11-git-send-email-pclouds@gmail.com>
 <20101115213059.GJ16385@burratino>
 <AANLkTimrm2ArRn9Ym271iFEv2bstPPD0WPuP0=Majf0K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 04:08:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIBu0-0005eC-IY
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 04:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759208Ab0KPDIH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 22:08:07 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42693 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab0KPDIF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 22:08:05 -0500
Received: by qwh6 with SMTP id 6so2124qwh.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 19:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZlTKVTbKxgKBKUYMUZBQK1A6+q93wt+SVk1XUKTYCMA=;
        b=rZZ/4okiJYe/MJCBcMDeKktaNaefadukJekvnSLZWxeIh02O/kdclVqtyH3zj2LBuy
         aAR/UIAK6Q/PeQ3TYg/7xwaq0s7FN1RbG+aVK9u36p4F+efAG/I9+uBFTVqwpk3l6Q/o
         1VvgtmaUUhNBHSPcXBFU3rkXiZnVbiU1e7+8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=j1YmvPGh6MZjEAX8MQHAvsIlyBkvLJLclTs0Ixn7T84YVJw3J3h3dUFxE0biUloZZ3
         BGgI5zdL0HrLrKruKXdkIXJDbhT6Z66TMN57Q16XBIKaVGLqrqH4pR9am/ZmHvXdhcbN
         dnG9FNrjPnNO7KIgQ4LPdTHWyxCt5t0uq0osQ=
Received: by 10.229.35.5 with SMTP id n5mr5666657qcd.175.1289876884720;
        Mon, 15 Nov 2010 19:08:04 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id s34sm450583qcp.44.2010.11.15.19.08.02
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 19:08:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimrm2ArRn9Ym271iFEv2bstPPD0WPuP0=Majf0K@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161536>

Nguyen Thai Ngoc Duy wrote:
> 2010/11/16 Jonathan Nieder <jrnieder@gmail.com>:

>> Hmm, that's new. =C2=A0Seems fine, though; a person using -S would b=
e
>> forwarned.
>
> It's safe, which is why I let it do that without '-f'. One can always
> checkout those entries again (provided that they know what entries to
> checkout).
>
> How do you want them to be warned?

Manual and -h output, ideally.

>		OPT_BOOLEAN('S', NULL, &sparse, "remove tracked files outside sparse=
 checkout"),

Maybe something to the effect of

		OPT_SET_INT('S', NULL, &sparse,
			"prune worktree to sparse pattern (even without -f)", 1),

Probably someone will chime in with the perfect wording that fits
in the 80-column "git clean -h" output format. :)
