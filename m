From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 08/31] parse_pathspec: add PATHSPEC_EMPTY_MATCH_ALL
Date: Tue, 22 Jan 2013 09:46:48 +0700
Message-ID: <CACsJy8BVf4FmxCHjksV_yQ0165coarCoW=jWtF2O5y8xuZ4=RQ@mail.gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
 <1358080539-17436-9-git-send-email-pclouds@gmail.com> <CANiSa6gfTxOWzMg7V19PntDBhU4kW6qpa+K2XjnWgzNRXDKRSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 03:47:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxTtk-0006Ll-2M
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 03:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab3AVCrT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 21:47:19 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:39091 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab3AVCrS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 21:47:18 -0500
Received: by mail-ob0-f177.google.com with SMTP id wc20so5896786obb.36
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 18:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=cK24Rf7NBqrfsIRNgWdjlPLT5ea4PIRgNmHUzl9YocE=;
        b=woU1V5H/xb/3VO67mJL0jpqwIp6iV75e0THSSp7hjxJkMCCXF84bXmtHYpbYJcJXBX
         F4/JNNcT1oA8JJQ2N5WQa2Q59bR1Zq9W0FCsPNMvT1uxggSna7ZFFK9LKYvVGBef+712
         LH9aNyVuPniJRD1BkiKFFazZersIA8JJoUv6NoQulQWjJ93JUBKpL7SOQ0sdMoAf3zgs
         n1vMWWAaTZiEge66OxBs5/BKGOIAhxisda8vS53ACydTHgqoGFGN+C10c7LQeAepECpj
         XtvCSmIAgW7OMvXM+zEgMxn9Y00N2rw2IR1w5s1boUmDPEnT54OjWO1bcDesF5rwcnQT
         7+zg==
X-Received: by 10.60.32.44 with SMTP id f12mr16125116oei.61.1358822838393;
 Mon, 21 Jan 2013 18:47:18 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Mon, 21 Jan 2013 18:46:48 -0800 (PST)
In-Reply-To: <CANiSa6gfTxOWzMg7V19PntDBhU4kW6qpa+K2XjnWgzNRXDKRSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214189>

On Tue, Jan 22, 2013 at 6:12 AM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
> Hi,
>
> I was tempted to ask this before, and the recent thread regarding "ad=
d
> -u/A" [1] convinced me to.
>
> On Sun, Jan 13, 2013 at 4:35 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> We have two ways of dealing with empty pathspec:
>>
>> 1. limit it to current prefix
>> 2. match the entire working directory
>>
>> Some commands go with #1, some with #2. get_pathspec() and
>> parse_pathspec() only supports #1. Make it support #2 too via
>> PATHSPEC_EMPTY_MATCH_ALL flag.
>
> If #2 is indeed the direction we want to go, then maybe we should mak=
e
> that the default behavior from parse_pathspec()? I.e. rename the flag
> "PATHSPEC_EMPTY_MATCH_PREFIX" (or something). Makes sense?

No problem with me. Will do unless someone objects.

> Btw, Matthieu was asking where we use #1. If you do invert the name
> and meaning of the flag, then the answer to that question should be
> (mostly?) obvious from a re-roll of your series (i.e. all the places
> where PATHSPEC_EMPTY_MATCH_PREFIX is used).
>
> Martin
>
>  [1] http://thread.gmane.org/gmane.comp.version-control.git/213988/fo=
cus=3D214113
--=20
Duy
