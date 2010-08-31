From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 05/17] gettext: make the simple parts of git-init localizable
Date: Tue, 31 Aug 2010 15:37:19 +0000
Message-ID: <AANLkTikd7mc4DjTVaKip_WFqVdezE13ZbL+Vmfqd8yCu@mail.gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
	<1283203703-26923-6-git-send-email-avarab@gmail.com>
	<20100831150301.GE2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 17:37:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqStt-0002o1-OC
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509Ab0HaPhW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 11:37:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62758 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757441Ab0HaPhV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 11:37:21 -0400
Received: by fxm13 with SMTP id 13so3996075fxm.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Adl8VPQAAxbhmxVyTIWUK8lqgOErRuhY/cFkwPGFCBE=;
        b=liBxmqZSfSWgtXqwaecrXCutzplI0IvUMBA+Vs9krackGoE9g5onqXUFDMDT+J5w/K
         8K8xcaiPu3+yaD6uYfN5VjJAGVZw1FHpg6BR5s4daJApA6H4fzX8NhtyqQ91Wa3EOSg2
         OS4783K0/wbvyH7c3H8qzTTvxZS7afgLkujv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YHWKahd2iLXHLWu81pkDQPxYP9GfeszSVdUtWEUirKXcdNgrW/SeZkfpSBXlEIbqGr
         9cA+QnBPCGmPDBw26wVUG9zWJ1zDDuW0yEZ2FGwK+6tB2uVlrNSSfqKyRpm2n2AvnomB
         NiRs655upFLZQPKbi2uTo0Z3bQqdLsiatE0GA=
Received: by 10.223.108.80 with SMTP id e16mr2486967fap.16.1283269039685; Tue,
 31 Aug 2010 08:37:19 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Tue, 31 Aug 2010 08:37:19 -0700 (PDT)
In-Reply-To: <20100831150301.GE2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154914>

On Tue, Aug 31, 2010 at 15:03, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> --- a/builtin/init-db.c
>> +++ b/builtin/init-db.c
>> @@ -31,7 +31,7 @@ static void safe_create_dir(const char *dir, int s=
hare)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 else if (share && adjust_shared_perm(dir))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Could not make %s w=
ritable by group", dir);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("Could not make %s=
 writable by group"), dir);
>
> Sensible.
>
> I wonder if die() should not just be taught to automatically look up
> translations for its format string (could gettext handle that?).

It's always a two step process. First you have to mark the messages
for translation, then you have to call gettext() (or _())on them to
make a lookup in the message catalog.

The only way that could work is if I taught xgettext to extract
strings passed to die(), but then managing the false positives would
probably be more effort than just marking them manually, and it would
be a big load on the translators:

    $ ack 'die\("(.*?)"' --output '$1' *[ch] builtin/*[ch] | sort -u | =
wc -l
    1153

> Although we try not to change plumbing error messages without good
> reason, details of error messages change often enough that imvho
> scripts should not be relying on them.
>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die_errno("cannot stat '%s'", path);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die_errno(_("cannot stat '%s'"), path);
>
> Will strerror() cope correctly without LC_CTYPE set up? =C2=A0(Not pa=
rt
> of this series, just something I was reminded of.)

My GNU/Linux strerror(3) claims to use LC_MESSAGES, but I didn't test
it.
