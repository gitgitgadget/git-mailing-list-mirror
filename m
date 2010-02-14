From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH] Add an optional argument for --color options
Date: Sun, 14 Feb 2010 09:46:35 -0500
Message-ID: <ca433831002140646v57ce6b1dm4d372d07b0220a16@mail.gmail.com>
References: <1266098475-21929-1-git-send-email-lodatom@gmail.com> 
	<7vmxzcoxla.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 15:47:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgfkW-0003bb-LL
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 15:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933Ab0BNOq6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 09:46:58 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:51570 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab0BNOq5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Feb 2010 09:46:57 -0500
Received: by qw-out-2122.google.com with SMTP id 5so310278qwi.37
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 06:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=H8CcYPMc5dG0F1Fsfo+vKCtdlARiKcghDAfalSjrNtg=;
        b=bp47txDRfRob+SeQk6rkw9JaBFrVNAYuKbwqbLLVJ30MaJeuKuRsg0Xv66Mo+Pmq/f
         8OlZuD69mprAed2ab8xu6LVx7IRed2hAZJ6mgYrPrpzlo43mUoHveOrugQnJIVSff+Dm
         0YtGeRDc2K430bYENE47z/7Vsy9MynHTFyRAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=r9MickbOglKCtEBn9nvCSjSVrfPRX+zPtuXsfLhY4EKMVNf+u6BMXPqJM5YJRTgkqf
         FCDKFmyvqWnhliFAn283tQwTKKsCBdyyXF6kK8Dwp9T81Es8eopHOJLKRBHZ0CPoFlMG
         lGPVBO1QgNtbj83a+bea/4Nr21Mue9KBO9wGM=
Received: by 10.224.101.146 with SMTP id c18mr1843118qao.269.1266158815125; 
	Sun, 14 Feb 2010 06:46:55 -0800 (PST)
In-Reply-To: <7vmxzcoxla.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139909>

On Sun, Feb 14, 2010 at 6:39 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Mark Lodato <lodatom@gmail.com> writes:
>>
>> +`OPT_COLOR_FLAG(short, long, &int_var, description)`::
>> + =C2=A0 =C2=A0 Introduce an option that takes an optional argument =
that can
>> + =C2=A0 =C2=A0 have one of three values: "always", "never", or "aut=
o". =C2=A0If the
>> + =C2=A0 =C2=A0 argument is not given, it defaults to "always". =C2=A0=
The +--no-+ form
>> + =C2=A0 =C2=A0 works like +--long=3Dnever+; it cannot take an argum=
ent. =C2=A0If
>> + =C2=A0 =C2=A0 "always", set +int_var+ to 1; if "never", set +int_v=
ar+ to 0; if
>> + =C2=A0 =C2=A0 "auto", set +int_var+ to 1 if stdout is a tty or a p=
ager,
>> + =C2=A0 =C2=A0 0 otherwise.
>> +
>
> Everybody else in the vicinity seems to write these like `--something=
` and
> this new paragraph uses '+--something+'. =C2=A0Why be original only t=
o be
> different? =C2=A0Is the mark-up known to be understood by various ver=
sions of
> AsciiDoc people use?

In my version of AsciiDoc (8.4.4), backticks were not rendering
correctly.  Instead they were showing up starting with an opening
quote and ending with a grave accent.  The same problem was occurring
in the other paragraphs, too.  I believe the problem occurred whenever
there was a single quote on the same line as a backtick: AsciiDoc was
reading the first backtick to the first single quote as a quoted
string, rather than the first backtick to the second backtick as a
literal string.  So, I used +'s here to fix it in this paragraph, and
then I was going to post a patch to fix the others.    But, after I
emailed this patch, I realized that the 'html' branch does *not* have
this problem.  So, I'll change this to backticks in the next version
of the patch.

(In case you're wondering: no, there are no single quotes in the above
paragraph, but there were in earlier versions.  I didn't realize it
was a single quote issue until now.)

>> diff --git a/color.c b/color.c
>> index 62977f4..790ac91 100644
>> --- a/color.c
>> +++ b/color.c
>> @@ -138,6 +138,9 @@ int git_config_colorbool(const char *var, const =
char *value, int stdout_is_tty)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto auto_color;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> + =C2=A0 =C2=A0 /* If var is not given, return an error */
>> + =C2=A0 =C2=A0 if (!var)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>
> This is not a good comment for more than one reasons:
>
> [...]
>

You're right, it's a crappy comment.  Should I try to reword it, or
just leave it out?

>> diff --git a/diff.c b/diff.c
>> index 381cc8d..110e63b 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -2826,6 +2826,15 @@ int diff_opt_parse(struct diff_options *optio=
ns, const char **av, int ac)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DIFF_OPT_SET(option=
s, FOLLOW_RENAMES);
>> =C2=A0 =C2=A0 =C2=A0 else if (!strcmp(arg, "--color"))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DIFF_OPT_SET(option=
s, COLOR_DIFF);
>> + =C2=A0 =C2=A0 else if (!prefixcmp(arg, "--color=3D")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int value =3D git_config=
_colorbool(NULL, arg+8, -1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value =3D=3D 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 DIFF_OPT_CLR(options, COLOR_DIFF);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (value > 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 DIFF_OPT_SET(options, COLOR_DIFF);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return 0;
>
> Earlier you said "git diff --blorb" says "error: invalid option: --bl=
orb"
> and that is unhelpful, but I do not understand why that justifies to
> silently ignore "git diff --color=3Dbogo".

"git diff --color=3Dbogo" is not silently ignored.  A useless message i=
s
printed instead.

$ ./git-diff --color=3Dasdf
error: invalid option: --color=3Dasdf

I did this because that's what the surrounding code did.  Instead, I
would have preferred

    return error("option `color' expects \"always\", \"auto\", or \"nev=
er\"");

which seems to work.  Is this the right way to go?

> [...]
> missing SP after colon.

Oops.  Fixed.

>> +     value =3D git_config_colorbool(NULL, arg, -1);
>> +     if (value < 0)
>> +             return opterror(opt, "expects \"always\", \"auto\", "
>> +                             "or \"never\"", 0);
>
> Instead of breaking a string into two lines, please write it like thi=
s:
>
>                return opterror(opt,
>                        "expects \"always\", \"auto\", or \"never\"", =
0);
>
> so that we can grep.

How do you prefer to handle really long lines?  Just let them extend
past 80 columns?  This is what appears to be the convention, but I
just want to double check.


I have some other color-related patches that I plan to email today.
They are all essentially independent, meaning you can accept some but
not others, but I will roll them all into a single PATCHv2 thread so
that they stay together. That is, unless you'd prefer them to be
separate.

Thanks for the feedback,
Mark
