From: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
Subject: Re: [PATCH v6] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Fri, 18 Oct 2013 01:08:33 +0300
Message-ID: <B690713F-6FF1-46A7-85A7-C92303BBAF0E@gmail.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com> <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com> <660A536D-9993-4B81-B6FF-A113F9111570@gmail.com> <AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com> <79A13931-694C-4DDC-BEDF-71A0DBA0ECA1@gmail.com> <89A4E8C6-C233-49E2-8141-837ABDBBC976@gmail.com> <xmqqmwm71ysp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 18 00:08:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWvkI-00029V-0Z
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 00:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762895Ab3JQWIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Oct 2013 18:08:37 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:42812 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762801Ab3JQWIg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Oct 2013 18:08:36 -0400
Received: by mail-lb0-f179.google.com with SMTP id p9so2434357lbv.38
        for <git@vger.kernel.org>; Thu, 17 Oct 2013 15:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=gy72U8Whcwn4RaSrPazx9HXP6dFLKIM78CVkpO40GDM=;
        b=RNE0EZR/mEi3KP+Ah6AGWfSLwHLig1ahg63DoaOPVZmeaXnJr++8ZF1ELt0+QeRsJf
         mEuly5dwjECe4aNKfhoaJymJpy+z3Qv91/sQiGl3w3Iolr/obzMWrjHN04K+k5v9y/I9
         A07gcVhW4KrijCWzQ6Mq5MAefhW5HB4yJwyQW+Ye/AMiVMGjdEbd4E/nlVQQujiANwJv
         Q/13tgjBtB0aJlra8aq2tsyWLRtFWhbaa2KUuGNw4bDxba+JQS/KPczNNHeLsxmnb/iZ
         tk70OXBJcobuoWYgWg9Aix5eIOid8h50kFqvZ1q0zvCwaMQK10z85gmsVigbF7Pdva1+
         plxQ==
X-Received: by 10.152.29.103 with SMTP id j7mr8747973lah.7.1382047715382;
        Thu, 17 Oct 2013 15:08:35 -0700 (PDT)
Received: from [192.168.0.14] (cs27064221.pp.htv.fi. [89.27.64.221])
        by mx.google.com with ESMTPSA id m13sm56276353lbo.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 15:08:34 -0700 (PDT)
In-Reply-To: <xmqqmwm71ysp.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236327>

Hello Junio

Thank you very much for the reviewing.
I try to fix the issues, and posted the updated patch as "[PATCH v7]".

> I am not sure if distributing the burden of truncation equally to
> three parts so that the resulting pieces are of similar lengths is
> really a good idea.  Between these two
>=20
> 	{...SourceDirectory =3D> ...nationDirectory}...ileThatWasMoved=20
> 	{...ceDirectory =3D> ...ionDirectory}nameOfTheFileThatWasMoved
>=20
> that attempt to show that the file nameOfTheFileThatWasMoved was
> moved from the longSourceDirectory to the DestinationDirectory, the
> latter is much more informative, I would think.
In the "[PATCH v7]", I changed to keep filename part of suffix to handl=
e
above case, but not always keep directory part because I feel totally
keeping all part of long suffix including directory name may cause outp=
ut like:
    =E2=80=A6{=E2=80=A6 =3D> =E2=80=A6}=E2=80=A6ongPath1/LongPath2/name=
OfTheFileThatWasMoved=20
And, above may be worse than:
   ...{...ceDirectory =3D> =E2=80=A6ionDirectory}.../nameOfTheFileThatW=
asMoved
I think.

Thank you !

---
Tsuneo Yoshioka (=E5=90=89=E5=B2=A1 =E6=81=92=E5=A4=AB)
yoshiokatsuneo@gmail.com




On Oct 17, 2013, at 10:29 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Yoshioka Tsuneo <yoshiokatsuneo@gmail.com> writes:
>=20
>> "git diff -M --stat" can detect rename and show renamed file name li=
ke
>> "foofoofoo =3D> barbarbar".
>> Before this commit, this output is shortened always by omitting left=
 most
>> part like "...foo =3D> barbarbar". So, if the destination filename i=
s too long,
>> source filename putting left or arrow can be totally omitted like
>> "...barbarbar", without including any of "foofoofoo =3D>".
>> In such a case where arrow symbol is omitted, there is no way to kno=
w
>> whether the file is renamed or existed in the original.
>> Make sure there is always an arrow, like "...foo =3D> ...bar".
>> The output can contain curly braces('{','}') for grouping.
>> So, in general, the output format is "<pfx>{<mid_a> =3D> <mid_b>}<sf=
x>"
>> To keep arrow("=3D>"), try to omit <pfx> as long as possible at firs=
t
>> because later part or changing part will be the more important part.
>> If it is not enough, shorten <mid_a>, <mid_b>, and <sfx> trying to
>> have the maximum length the same because those will be equally impor=
tant.
>=20
> I somehow find this solid wall of text extremely hard to
> read. Adding a blank line as a paragraph break may make it easier to
> read, perhaps.
>=20
> Also it is customary in our history to omit the full-stop from the
> patch title on the Subject: line.
>=20
>> +	name_len =3D pfx->len + a_mid->len + b_mid->len + sfx->len + strle=
n(arrow)
>> +		+ (use_curly_braces ? 2 : 0);
>> +
>> +	if (name_len <=3D name_width) {
>> +		/* Everthing fits in name_width */
>> +		return;
>> +	}
>=20
> Logic up to this point seems good; drop {} around a single statement
> "return;", i.e.
>=20
> 	if (name_len <=3D name_width)
>        	return; /* everything fits */
>=20
>> +		} else {
>> +			if (pfx->len > strlen(dots)) {
>> +				/*
>> +				 * Just omitting left of '{' is not enough
>> +				 * name will be "...{SOMETHING}SOMETHING"
>> +				 */
>> +				strbuf_reset(pfx);
>> +				strbuf_addstr(pfx, dots);
>> +			}
>=20
> (mental note) ... otherwise, i.e. with a short common prefix, the
> final result will be "ab{SOMETHING}SOMETHING", which is also fine
> for the purpose of the remainder of this function.
>=20
>> +		}
>> +	}
>> +
>> +	/* available length for a_mid, b_mid and sfx */
>> +	len =3D name_width - strlen(arrow) - (use_curly_braces ? 2 : 0);
>> +
>> +	/* a_mid, b_mid, sfx will be have the same max, including ellipsis=
("..."). */
>> +	part_length[0] =3D a_mid->len;
>> +	part_length[1] =3D b_mid->len;
>> +	part_length[2] =3D sfx->len;
>> +
>> +	qsort(part_length, sizeof(part_length)/sizeof(part_length[0]), siz=
eof(part_length[0])
>> +		  , compare_size_t_descending_order);
>=20
> In our code, comma does not come at the beginning of continued
> line.
>=20
>> +	if (part_length[1] + part_length[1] + part_length[2] <=3D len) {
>> +		/*
>> +		 * "{...foofoo =3D> barbar}file"
>> +		 * There is only one omitted part.
>> +		 */
>> +		max_part_len =3D len - part_length[1] - part_length[2];
>=20
> It would be clearer to explicitly set remainder to zero here, and
> omit the initialization of the variable.  That would make what the
> three parts of if/elseif/else do more consistent.
>=20
>> +	} else if (part_length[2] + part_length[2] + part_length[2] <=3D l=
en) {
>> +		/*
>> +		 * "{...foofoo =3D> ...barbar}file"
>> +		 * There are 2 omitted parts.
>> +		 */
>> +		max_part_len =3D (len - part_length[2]) / 2;
>> +		remainder_part_len =3D (len - part_length[2]) - max_part_len * 2;
>> +	} else {
>> +		/*
>> +		 * "{...ofoo =3D> ...rbar}...file"
>> +		 * There are 3 omitted parts.
>> +		 */
>> +		max_part_len =3D len / 3;
>> +		remainder_part_len =3D len - (max_part_len) * 3;
>> +	}
>=20
> I am not sure if distributing the burden of truncation equally to
> three parts so that the resulting pieces are of similar lengths is
> really a good idea.  Between these two
>=20
> 	{...SourceDirectory =3D> ...nationDirectory}...ileThatWasMoved=20
> 	{...ceDirectory =3D> ...ionDirectory}nameOfTheFileThatWasMoved
>=20
> that attempt to show that the file nameOfTheFileThatWasMoved was
> moved from the longSourceDirectory to the DestinationDirectory, the
> latter is much more informative, I would think.
>=20
>> diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
>> index 2f327b7..03d6371 100755
>> --- a/t/t4001-diff-rename.sh
>> +++ b/t/t4001-diff-rename.sh
>> @@ -156,4 +156,16 @@ test_expect_success 'rename pretty print common=
 prefix and suffix overlap' '
>> 	test_i18ngrep " d/f/{ =3D> f}/e " output
>> '
>>=20
>> +test_expect_success 'rename of very long path shows =3D>' '
>> +	mkdir long_dirname_that_does_not_fit_in_a_single_line &&
>> +	mkdir another_extremely_long_path_but_not_the_same_as_the_first &&
>> +	cp path1 long_dirname*/ &&
>> +	git add long_dirname*/path1 &&
>> +	test_commit add_long_pathname &&
>> +	git mv long_dirname*/path1 another_extremely_*/ &&
>> +	test_commit move_long_pathname &&
>> +	git diff -M --stat HEAD^ HEAD >output &&
>> +	test_i18ngrep "=3D>.*path1" output
>=20
> Does this have to be i18ngrep?  I had a feeling that we would not
> want this part of the output localized, in which case "grep" may be
> more appropriate.
>=20
>> +'
>> +
>> test_done
