From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] Move header files into a include/ subdirectory
Date: Fri, 18 Feb 2011 10:52:21 +0700
Message-ID: <AANLkTi=VhJi4eDrtRPHukckQKo9TYCcnh1_u0_tnv24z@mail.gmail.com>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org> <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie> <20110218023750.GD23435@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 04:54:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqHQo-0008Kw-Nw
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 04:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984Ab1BRDyy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Feb 2011 22:54:54 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58416 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869Ab1BRDyw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 22:54:52 -0500
Received: by wwa36 with SMTP id 36so3344846wwa.1
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 19:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=siVExjArCD0zqWsYsFlZMd27AzY6BA2rpWUfJtp4CJQ=;
        b=QX1Y1fvMwJFoK+rz7nbYoxsCgijhJjPVDmcdJAUD17EmPrLk0pK8sFhL/voAJDgGBX
         0dA8ZLLRfHXI43vW1YPTo/boX32im+t4pZ6ZEbK0jZEYbn5eJ+m/4QzvSq8UqMcBBaxU
         QYfq5EenPqu1ZAlS5bBYP1W847IC9lyHEysRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HIaHRxjOrWqgQj3bEnkVuyBr7/ZB7LWZj2oZItL9brtHzd/IMceQxxEI3cA6+v/qxu
         oHwnS73eVWiOIVfcJhbHb4S/edKguUd8suzPLKKVQhfNj/aWV7tfKHqyvCfetaAYY6bc
         +dxiC+MsCGEoECvk0pLzUKUn8o6/4Nn6Tn//I=
Received: by 10.216.163.69 with SMTP id z47mr181347wek.43.1298001171114; Thu,
 17 Feb 2011 19:52:51 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Thu, 17 Feb 2011 19:52:21 -0800 (PST)
In-Reply-To: <20110218023750.GD23435@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167159>

2011/2/18 Jonathan Nieder <jrnieder@gmail.com>:
> Move most of git's header files to an include/ subdirectory.
> This leaves us with 71 fewer files in the toplevel directory,
> making the high-level structure of the codebase a little easier
> to see.
>
> Three headers stay behind, at least for now: git-compat-util.h,
> strbuf.h, and cache.h are referred to by some system-specific code
> (in compat/) using paths starting with "..". =C2=A0Making these three=
 core
> headers especially visible doesn't seem like a bad idea, anyway.

Perhaps it's time to split a large portion of cache.h to libgit.h and
make cache.h include libgit.h.

cache.h and git-compat-util.h at topdir is ok to me. strbuf.h should
go to libgit though, imo.

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
--=20
Duy
