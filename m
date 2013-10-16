From: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
Subject: Re: [PATCH v5] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Wed, 16 Oct 2013 12:53:53 +0300
Message-ID: <027C65BD-1110-4EBA-B854-16F15F85952A@gmail.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com> <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com> <660A536D-9993-4B81-B6FF-A113F9111570@gmail.com> <AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com> <79A13931-694C-4DDC-BEDF-71A0DBA0ECA1@gmail.com> <xmqqbo2qb0wk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Keshav Kini <keshav.kini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 11:54:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWNno-00015E-Ud
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 11:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760236Ab3JPJyA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Oct 2013 05:54:00 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36535 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760162Ab3JPJx6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Oct 2013 05:53:58 -0400
Received: by mail-lb0-f175.google.com with SMTP id y6so480417lbh.34
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 02:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=Jz3dNzg7n4PdSmUggvdHVqmK/xE6LRr+4qjCL5SHekc=;
        b=b9a8NugZM0RD7b/Kc4bjk5yzBcq08Ut4c//qcWKlFDnb+MyMM5+54Ma3ozOOwYqAgv
         7CuKkW70NPYcpjjWnoNfSz/TzA9ygREiUvbQgqoBm12OGVnm+X+6W+leR2XotGzsXbxo
         NH9COlHecuCxR+QMTjq2U7mBlInSlX2ggE2DT0QNmNjUNlMKbzOTf6lkZKHTQCDjgV7M
         8qJRJdF57+xMoecTUMk6+Qg61a4uf4v9xbN9+5iBZDIXC0ym80n7a1jWI8n1AtFhEaFA
         /8C1+Ve55xTkWRfBhpa2w/dS+3NPLCg9rcv9RulM55zq6yQtzmS2SDVazXS0Jzi3rVNo
         X8fA==
X-Received: by 10.152.26.72 with SMTP id j8mr1696251lag.19.1381917237122;
        Wed, 16 Oct 2013 02:53:57 -0700 (PDT)
Received: from [10.128.134.109] (fsgw.f-secure.com. [193.110.108.33])
        by mx.google.com with ESMTPSA id b1sm69036926lah.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Oct 2013 02:53:56 -0700 (PDT)
In-Reply-To: <xmqqbo2qb0wk.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236242>

Hello Junio, Keshav

Thank you very much for your detailed reviewing.
I just tried to update the patch and posted as "[PATCH v6]".

---
Tsuneo Yoshioka (=E5=90=89=E5=B2=A1 =E6=81=92=E5=A4=AB)
yoshiokatsuneo@gmail.com




On Oct 16, 2013, at 1:54 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Yoshioka Tsuneo <yoshiokatsuneo@gmail.com> writes:
>=20
>> "git diff -M --stat" can detect rename and show renamed file name li=
ke
>> "foofoofoo =3D> barbarbar". But if destination filename is long, the=
 line
>> is shortened like "...barbarbar" so there is no way to know whether =
the
>> file is renamed or existed in the source commit.
>=20
> Is "destination" filename more special than the source filename?
> Perhaps "s/if destination filename is/if filenames are/"?
>=20
> 	Note: I do not want you to reroll using the suggested
> 	wording without explanation; it may be possible that I am
> 	missing something obvious and do not understand why you
> 	singled out destination, in which case I'd rather see it
> 	explained better in the log message than the potentially
> 	suboptimal suggestion I made in the review without
> 	understanding the issue. Of course, it is possible that you
> 	want to do the same when source is overlong, in which case
> 	you can just say "Yeah, you're right; will reroll".
>=20
>        The above applies to all the other comments in this message.
>=20
> Also "s/source commit/original/".  You may not be comparing two
> commits after all.
>=20
>> Make sure there is always an arrow, like "...foo =3D> ...bar".
>> The output can contains curly braces('{','}') for grouping.
>=20
> s/contains/contain/;
>=20
>> So, in general, the outpu format is "<pfx>{<mid_a> =3D> <mid_b>}<sfx=
>"
>=20
> s/outpu/&t/;
>=20
>> To keep arrow("=3D>"), try to omit <pfx> as long as possible at firs=
t
>> because later part or changing part will be the more important part.
>> If it is not enough, shorten <mid_a>, <mid_b>, and <sfx> trying to
>> have the maximum length the same because those will be equaly import=
ant.
>=20
> A sound reasoning.
>=20
>> Signed-off-by: Tsuneo Yoshioka <yoshiokatsuneo@gmail.com>
>> Test-added-by: Thomas Rast <trast@inf.ethz.ch>
>> ---
>> diff.c                 | 187 +++++++++++++++++++++++++++++++++++++++=
++++------
>> t/t4001-diff-rename.sh |  12 ++++
>> 2 files changed, 177 insertions(+), 22 deletions(-)
>>=20
>> diff --git a/diff.c b/diff.c
>> index a04a34d..cf50807 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -1258,11 +1258,12 @@ static void fn_out_consume(void *priv, char =
*line, unsigned long len)
>> 	}
>> }
>>=20
>> -static char *pprint_rename(const char *a, const char *b)
>> +static void pprint_rename_find_common_prefix_suffix(const char *a, =
const char *b
>> +													, struct strbuf *pfx, struct strbuf *a_mid
>> +													, struct strbuf *b_mid, struct strbuf *sfx)
>=20
> What kind of line splitting is this?
>=20
> I think the real issue is that the function name is overly long, but
> aside from that,
>=20
> - comma comes at the end of the line, not at the beginning of the
>   next line;
>=20
> - the second and subsequent lines are indented, but not more than
>   the usual line width (align with the first letter inside the
>   opening parenthesis of the first line);
>=20
> - a_mid and b_mid are more "alike" than pfx and a_mid.
>=20
> so I would expect to see it more like:
>=20
> static void abbrev_rename(const char *a, const char *b,
> 			  struct strbuf *pfx,
> 			  struct strbuf *a_mid, struct strbuf *b_mid,
> 			  struct strbuf *sfx)
>=20
> Note that the suggested name does not say "pprint", because in your
> version of this file, the code around here is no longer doing any
> printing.  The caller does so after using this function to decide
> how to abbreviate renames, so naming the helper function after what
> it does (e.g. abbreviate renames) is more appropriate.
>=20
>> {
>> 	const char *old =3D a;
>> 	const char *new =3D b;
>> -	struct strbuf name =3D STRBUF_INIT;
>> 	int pfx_length, sfx_length;
>> 	int pfx_adjust_for_slash;
>> 	int len_a =3D strlen(a);
>> @@ -1272,10 +1273,9 @@ static char *pprint_rename(const char *a, con=
st char *b)
>> 	int qlen_b =3D quote_c_style(b, NULL, NULL, 0);
>>=20
>> 	if (qlen_a || qlen_b) {
>> -		quote_c_style(a, &name, NULL, 0);
>> -		strbuf_addstr(&name, " =3D> ");
>> -		quote_c_style(b, &name, NULL, 0);
>> -		return strbuf_detach(&name, NULL);
>> +		quote_c_style(a, a_mid, NULL, 0);
>> +		quote_c_style(b, b_mid, NULL, 0);
>> +		return;
>> 	}
>>=20
>> 	/* Find common prefix */
>> @@ -1321,18 +1321,151 @@ static char *pprint_rename(const char *a, c=
onst char *b)
>> 		a_midlen =3D 0;
>> 	if (b_midlen < 0)
>> 		b_midlen =3D 0;
>> +=09
>=20
> Trailing whitespace (there are many others you added to this file; I
> won't bother to point out all of them).
>=20
>> +	strbuf_add(pfx, a, pfx_length);
>> +	strbuf_add(a_mid, a + pfx_length, a_midlen);
>> +	strbuf_add(b_mid, b + pfx_length, b_midlen);
>> +	strbuf_add(sfx, a + len_a - sfx_length, sfx_length);
>> +}
>> +
>> +/*
>> + * Omit each parts to fix in name_width.
>> + * Formatted string is "<pfx>{<a_mid> =3D> <b_mid>}<sfx>".
>> + * At first, omit <pfx> as long as possible.
>> + * If it is not enough, omit <a_mid>, <b_mid>, <sfx> by tring to se=
t the length of
>> + * those 3 parts(including "...") to the same.
>> + * Ex:
>> + * "foofoofoo =3D> barbarbar"
>> + *   will be like
>> + * "...foo =3D> ...bar".
>> + * "long_parent{foofoofoo =3D> barbarbar}longfilename"
>> + *   will be like
>> + * "...parent{...foofoo =3D> ...barbar}...lename"
>> + */
>> +static void pprint_rename_omit(struct strbuf *pfx, struct strbuf *a=
_mid, struct strbuf *b_mid
>> +							   , struct strbuf *sfx, int name_width)
>=20
> Bad line splitting.
>=20
>> +{
>> +
>> +#define ARROW " =3D> "
>> +#define ELLIPSIS "..."
>=20
> Ugly and leaks these symbols after the function is done using them
> to the remainder of this file.  Write them like this instead, perhaps=
?
>=20
> 	static const char arrow[] =3D " =3D> ";
>        static const char dots[] =3D "...";
>=20
>> +#define swap(a, b) myswap((a), (b), sizeof(a))
>> +=09
>> +#define myswap(a, b, size) do {		\
>> +unsigned char mytmp[size];	\
>> +memcpy(mytmp, &a, size);		\
>> +memcpy(&a, &b, size);		\
>> +memcpy(&b, mytmp, size);		\
>> +} while (0)
>=20
> These are totally unneeded, I suspect (see below).
>=20
>> +
>> +	int use_curly_braces =3D (pfx->len > 0) || (sfx->len > 0);
>> +	size_t name_len;
>> +	size_t len;
>> +	size_t part_lengths[4];
>=20
> Do not name an array in plural, i.e. elements[], unless there is a
> compelling reason to do so.  By using singular, e.g. element[], the
> third element can be spelled as element[3], which is more logical
> than having to call it elements[3].
>=20
> 	Side note. a notable exception is an array that is used as a
> 	hash-table and frequently passed around as an argument; you
> 	are usually not interested in iterating over it in ascending
> 	order, and being able to call such a collection of things
> 	"things" in plural, e.g. struct object objects[], is more
> 	important.
>=20
>> +	size_t max_part_len =3D 0;
>> +	size_t remainder_part_len =3D 0;
>> +	int i, j;
>> +
>> +	name_len =3D pfx->len + a_mid->len + b_mid->len + sfx->len + strle=
n(ARROW)
>> +		+ (use_curly_braces ? 2 : 0);
>> +=09
>> +	if (name_len <=3D name_width) {
>> +		/* Everthing fits in name_width */
>> +		return;
>> +	}
>> +=09
>> +	if (use_curly_braces) {
>> +		if (strlen(ELLIPSIS) + (name_len - pfx->len) <=3D name_width) {
>> +			/*
>> +			 Just omitting left of '{' is enough
>> +			 Ex: ...aaa{foofoofoo =3D> bar}file
>> +			 */
>=20
> 	/*
>         * We format our multi-line
>         * comments like
>         * this.
>         */
>=20
>> +			strbuf_splice(pfx, name_len - pfx->len, name_width - (name_len -=
 pfx->len), ELLIPSIS, strlen(ELLIPSIS));
>=20
> Overlong line.
>=20
> Is the math for the second and third arguments correct?  If you are
> making "abcdefghij" into "...hij", you would splice at position 0
> for length up to 'g', so it felt strange to see any arithmetic as
> the second argument, but I didn't look at this code very closely.
>=20
>> +			return;
>> +		} else {
>> +			if (pfx->len > strlen(ELLIPSIS)) {
>> +				/*
>> +				 Just omitting left of '{' is not enough
>> +				 name will be "...{SOMETHING}SOMETHING"
>> +				 */
>> +				strbuf_reset(pfx);
>> +				strbuf_addstr(pfx, ELLIPSIS);
>> +			}
>> +		}
>> +	}
>>=20
>> -	strbuf_grow(&name, pfx_length + a_midlen + b_midlen + sfx_length +=
 7);
>> -	if (pfx_length + sfx_length) {
>> -		strbuf_add(&name, a, pfx_length);
>> +	/* available length for a_mid, b_mid and sfx */
>> +	len =3D name_width - strlen(ARROW) - (use_curly_braces ? 2 : 0);
>> +=09
>> +	/* a_mid, b_mid, sfx will be have the same max, including ellipsis=
("..."). */
>> +	part_lengths[0] =3D (int)a_mid->len;
>> +	part_lengths[1] =3D (int)b_mid->len;
>> +	part_lengths[2] =3D (int)sfx->len;
>=20
> What are these casts about?  strbuf.len is of size_t which is
> already the correct type for part_length[].
>=20
>> +=09
>> +	/* bubble sort of part_lengths, descending order */
>=20
> Do not bubble sort.  Unless there is a compelling reason not to
> (liek you are in a performance critical section and want to use a
> custom sort algorithm), just let the platform-supplied qsort(3) do
> the job by writing a small comparison function.
>=20
>> +	for (i=3D0; i<3; i++) {
>> +		for (j=3Di+1; j<3; j++) {
>> +			if (part_lengths[j] > part_lengths[i]) {
>> +				swap(part_lengths[i], part_lengths[j]);
>> +			}
>> +		}
>> +	}
>> +=09
>> +	if (part_lengths[1] + part_lengths[1] + part_lengths[2] <=3D len) =
{
>> +		/*
>> +		 * "{...foofoo =3D> barbar}file"
>> +		 * There is only one omitting part.
>=20
> s/omitting/omitted/;
>=20
>> +		 */
>> +		max_part_len =3D len - part_lengths[1] - part_lengths[2];
>> +	} else if (part_lengths[2] + part_lengths[2] + part_lengths[2] <=3D=
 len) {
>> +		/*
>> +		 * "{...foofoo =3D> ...barbar}file"
>> +		 * There are 2 omitting part.
>=20
> s/omitting part/omitted parts/;
>=20
>> +		 */
>> +		max_part_len =3D (len - part_lengths[2]) / 2;
>> +		remainder_part_len =3D (len - part_lengths[2]) - max_part_len * 2=
;
>> +	} else {
>> +		/*
>> +		 * "{...ofoo =3D> ...rbar}...file"
>> +		 * There are 3 omitting part.
>=20
> Likewise.
>=20
