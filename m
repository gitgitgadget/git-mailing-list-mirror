From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 01/28] path.c: make get_pathname() return strbuf
 instead of static buffer
Date: Sat, 8 Mar 2014 15:57:49 +0700
Message-ID: <CACsJy8BMK-CkzQjx5cRA6EK4rHdvng9QtNuh5jexd2UKpM_CyA@mail.gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com> <1394246900-31535-2-git-send-email-pclouds@gmail.com>
 <531AB47B.7070506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 08 09:58:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMD5n-0001NJ-Uw
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 09:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbaCHI6U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Mar 2014 03:58:20 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:36875 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbaCHI6T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2014 03:58:19 -0500
Received: by mail-qa0-f46.google.com with SMTP id i13so5124783qae.33
        for <git@vger.kernel.org>; Sat, 08 Mar 2014 00:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MuLag/PDc6sbxjHaYI1LuKYOyZGiYVsBvwo5fwBmQPE=;
        b=fb0/jAVgxaRHpcdCk/UWMKZkNdpLz+xY6t13msSolUft0d7frRGdJTsO8tKnG5W5nZ
         9ajOYrj4jTf/rrqEQu6RjacR/y+x/KW+eqixpohulDQreJAPV0kF3FEoajVErcVCPHKB
         G1cfqCWAR0fN9H+aFG10lnznUPBnmDpUzPaa3Z+gE5luKuACrbGF40isLFZjZbOQaulY
         nmSSrSCL+Gmm1UhIN4Bvcb8lLWg5CwE14FlfqLnJ9W8Nh15Cdze8EkbHyjJdkxQpcwnO
         gHnTueRVL/4SuwSX6qjlAfqxSTdl1/F7POs7hVcJGwBwrwzWv7/O9sbHjffZRvanq7VM
         X8Zg==
X-Received: by 10.224.151.147 with SMTP id c19mr856974qaw.86.1394269099133;
 Sat, 08 Mar 2014 00:58:19 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sat, 8 Mar 2014 00:57:49 -0800 (PST)
In-Reply-To: <531AB47B.7070506@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243673>

On Sat, Mar 8, 2014 at 1:11 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 2014-03-08 03.47, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> We've been avoiding PATH_MAX whenever possible. This patch makes
>> get_pathname() return a strbuf and updates the callers to take
>> advantage of this. The code is simplified as we no longer need to
>> worry about buffer overflow.
>>
>> vsnpath() behavior is changed slightly: previously it always clears
> Minor question:
> Is the function name vsnpath() appropriate any more ?
> How about renaming the function into strbuf_vaddpath() ?

It is renamed in 04/28 to do_git_path().
--=20
Duy
