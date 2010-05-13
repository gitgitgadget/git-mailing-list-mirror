From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [RFC/PATCH v3 4/5] Rename "crlf" attribute as "eolconv"
Date: Thu, 13 May 2010 09:19:15 -0400
Message-ID: <AANLkTikat4Da_XXz8xYH9La_I3n31THIhGA_onGGm0VU@mail.gmail.com>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com>
	 <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com>
	 <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org>
	 <AANLkTilQjSKNYq8NEabcsZc5WWF86kWMWxnTy-mShVgS@mail.gmail.com>
	 <AANLkTimCraGNet9lCuJGmFNR5JcDRQBTz1yME6GQFo4B@mail.gmail.com>
	 <014C9B00-800C-465D-A0B9-98BEEB7D7A96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 15:25:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCYPY-0004j3-Hj
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 15:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab0EMNY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 May 2010 09:24:58 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:36431 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836Ab0EMNY4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 09:24:56 -0400
Received: by wwi18 with SMTP id 18so842154wwi.19
        for <git@vger.kernel.org>; Thu, 13 May 2010 06:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/0n7uRvQPuwZEj3byIciqwrO6SBZudq5fuIYSOV/n10=;
        b=Y+Kw+e0pbwOsLRBezndAZF6ozyKEKQ3o7MmzYDSX7oTxztien7LNzzYueawLBf97UB
         aj7Pb1GaXu1piesKvcQws8MyzGqYuh1v6ZqMPyWfWe4cvh66Yca5eVigtG+rxyCTugnc
         qDw9YS9tntdfZrRlBXUU5PM2zeWk5tPI/tcsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IVw5tJxC1VjkqsPGUkV2v7USo4A5H9H60uTu6/A/eDEiLUnCHXEIATf5TCLHx6HYrS
         jxANqb4AG3r94LrqDm/2XRDZ4C6IXzimWUV7pIraZGDjbRghfJfLlJJSRjtBPmqAmqqh
         I9zYoN1bJfXAtCmaM5Nk7hh3P424IRZg5EJUY=
Received: by 10.216.156.147 with SMTP id m19mr365753wek.162.1273756755609; 
	Thu, 13 May 2010 06:19:15 -0700 (PDT)
Received: by 10.216.7.207 with HTTP; Thu, 13 May 2010 06:19:15 -0700 (PDT)
In-Reply-To: <014C9B00-800C-465D-A0B9-98BEEB7D7A96@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147004>

On Thu, May 13, 2010 at 7:47 AM, Eyvind Bernhardsen
<eyvind.bernhardsen@gmail.com> wrote:
> On 13. mai 2010, at 11.58, Robert Buck wrote:
>
>> Quick question here, while people would be in the convert.c function=
s
>> when making the above changes. This question is related to detecting
>> whether a file is text, but the question could be spun off to a
>> different thread if you so wish...
>>
>> Have you considered skipping the UTF8 BOM and provided that the
>> remaining content is considered text allow auto conversions? The che=
ck
>> is simple, and would cover at least 50% of latin-derived languages.
>> Since you have the buffer at hand, and are in the same file
>> (convert.c), simply check for an initial EF BB BF. This would fix so=
me
>> text files created on Windows (someone had mentioned Notepad I
>> believe). Out of the box experience for eol and text detection for
>> Windows users would be improved.
>
> I just did a quick test with a plain text file; it was detected as te=
xt both with and without a utf8 BOM. =C2=A0Looking at the code, charact=
ers >=3D 128 are considered printable so the BOM shouldn't make any dif=
ference at all. =C2=A0Do you have an example utf8 text file that is mis=
detected as binary?

Sorry, my bad. I misread a line in convert.c. It handles UTF-8 beautifu=
lly.
