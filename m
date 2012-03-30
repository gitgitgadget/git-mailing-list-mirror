From: Bo Chen <chen@chenirvine.org>
Subject: Re: GSoC - Some questions on the idea of
Date: Fri, 30 Mar 2012 15:51:20 -0400
Message-ID: <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
	<CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
	<loom.20120328T131530-717@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sergio <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 21:51:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDhr5-0007Jq-1c
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 21:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934348Ab2C3TvX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Mar 2012 15:51:23 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58527 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934253Ab2C3TvV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Mar 2012 15:51:21 -0400
Received: by wgbdr13 with SMTP id dr13so900165wgb.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 12:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=U+a99x85m3TOoFTa2ruTMx5DqWAmeSsGH7sSQX0Rdxo=;
        b=R3dJySfarcduuDTidB7JTPGcNwDawbPpwfQlFQNkjWQQVVz9mBjGisByaV7qvwlLQG
         xu6XzPKTirhZhCzadeBUq0xio3jF2ThX0hgCmuKVZYzwIAOaNlbZazTnal8Is+n/3UWM
         UiraMntMfpvwB2nBSFEGrKvkULQuZkwQkbdzTSodG1Vv75iJWuaZeDGZKWcz5Q1v1JiN
         jLsEStcdungIskQimvWw1NPIHHuHM1mVIarBpdzp62G/QMHjykl9KxMOmjWppygkif1Y
         cWc3MX2WBluPaX3bZ1QvBA7YXple2X3TDMLiq7QbZdqDJXSR1UA8CLXPA/6Dmh6kVQCV
         1vSw==
Received: by 10.180.103.134 with SMTP id fw6mr180512wib.0.1333137080270; Fri,
 30 Mar 2012 12:51:20 -0700 (PDT)
Received: by 10.180.81.70 with HTTP; Fri, 30 Mar 2012 12:51:20 -0700 (PDT)
X-Originating-IP: [128.235.34.66]
In-Reply-To: <loom.20120328T131530-717@post.gmane.org>
X-Gm-Message-State: ALoCoQkczgOICwFwSH4pAScsUv1qtn/Fh/HiADmRbOkc1G4WcIkg3gPh3XA3xFAkBpGfEJ+gW6x3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194397>

Please neglect my last email.
=46ollowing is the version more readable.
The sub-problems of "delta for large file" problem.

1 large file

1.1 text file (always delta well? need to be confirmed)

1.2 binary file

1.2.1  general binary file (without encryption, compression. Other
cases which definitely can not delta well)

1.2.1.1 delta well (ok)
1.2.1.2 does not delta well (improvement?)

1.2.2  encrypted file (improvement? one straightforward method is to
decrypt the file before delta-ing it, however, we don't always have
the key for decryption. Other?)

1.2.3 compressed file (improvement? Decompress before delta-ing it? Oth=
er?)

Can anyone give me any feed back for further refining the problem. Than=
ks.

Bo

On Wed, Mar 28, 2012 at 7:33 AM, Sergio <sergio.callegari@gmail.com> wr=
ote:
> Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:
>
>>
>> On Wed, Mar 28, 2012 at 11:38 AM, Bo Chen <chen <at> chenirvine.org>=
 wrote:
>> > Hi, Everyone. This is Bo Chen. I am interested in the idea of "Bet=
ter
>> > big-file support".
>> >
>> > As it is described in the idea page,
>> > "Many large files (like media) do not delta very well. However, so=
me
>> > do (like VM disk images). Git could split large objects into small=
er
>> > chunks, similar to bup, and find deltas between these much more
>> > manageable chunks. There are some preliminary patches in this
>> > direction, but they are in need of review and expansion."
>> >
>> > Can anyone elaborate a little bit why many large files do not delt=
a
>> > very well?
>>
>> Large files are usually binary. Depends on the type of binary, they
>> may or may not delta well. Those that are compressed/encrypted
>> obviously don't delta well because one change can make the final
>> result completely different.
>
> I would add that the larger a file, the larger the temptation to use =
a
> compressed format for it, so that large files are often compressed bi=
naries.
>
> For these, a trick to obtain good deltas can be to decompress before =
splitting
> in chunks with the rsync algorithm. Git filters can already be used f=
or this,
> but it can be tricky to assure that the decompress - recompress round=
trip
> re-creates the original compressed file.
>
> Furhermore, some compressed binaries are internally composed by multi=
ple streams
> (think of a zip archive containing multiple files, but this is by no =
means
> limited to zip). In this case, it is frequent to have many possible o=
rderings of
> the streams. If so, the best deltas can be obtained by sorting the st=
reams in
> some 'canonical' order and decompressing. Even without decompressing,=
 sorting
> alone can obtain good results as long as changes are only due to chan=
ges in a
> single stream of the container. Personally, I know no example of git =
filters
> used to perform this sorting which can be extremely tricky in assurin=
g the
> possibility of recovering the file in the original stream order.
>
> Maybe (but this is just speculation), once the bup-inspired file chun=
king
> support is in place, people will start contributing filters to improv=
e the
> management of many types of standard files (obviously 'improve' in te=
rms of
> space efficiency as filters can be quite slow).
>
> Sergio
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
