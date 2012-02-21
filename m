From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Tue, 21 Feb 2012 21:45:13 +0700
Message-ID: <CACsJy8DE86qzA1=GiKZFRCt5aH8X4iMyDvfrhnqwmbq52szhHg@mail.gmail.com>
References: <20120215190318.GA5992@sigill.intra.peff.net> <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net> <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net> <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net> <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net> <87ty2l38ay.fsf@thomas.inf.ethz.ch>
 <20120220143644.GA13938@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 15:45:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzqyT-0007NE-Kp
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 15:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354Ab2BUOpp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 09:45:45 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:46068 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796Ab2BUOpo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 09:45:44 -0500
Received: by wics10 with SMTP id s10so3542701wic.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 06:45:43 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.14.73 as permitted sender) client-ip=10.180.14.73;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.14.73 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.14.73])
        by 10.180.14.73 with SMTP id n9mr26523905wic.16.1329835543427 (num_hops = 1);
        Tue, 21 Feb 2012 06:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=s06KDoNMdIZtPvYeCjcvyoUZY3t8YpoI/7fURR7d5ks=;
        b=hpjUDD/vkykmBByoqgvhl+aEkk+3dixUJvOdIrW0GgmtODnR8EIdoODOkgD8Lr4fNg
         Jy0mRN/7OuG0vGjasNOgCH7ce7r1wV/uo0H/ffoqfLPuIqteTUQ4BbsQihgnu6E52vr/
         E/r0c7lf1eu3SYbpO1j/TlkiJ++eEuBqrJNG0=
Received: by 10.180.14.73 with SMTP id n9mr22066591wic.16.1329835543321; Tue,
 21 Feb 2012 06:45:43 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Tue, 21 Feb 2012 06:45:13 -0800 (PST)
In-Reply-To: <20120220143644.GA13938@do>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191162>

On Mon, Feb 20, 2012 at 9:36 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On Mon, Feb 20, 2012 at 03:09:57PM +0100, Thomas Rast wrote:
>> > Interestingly, on my git.git repo, I had an empty cache. Running "=
git
>> > read-tree HEAD" filled it (according to test-dump-cache-tree). It =
seems
>> > that running "git checkout" empties the cache. =C2=A0So perhaps gi=
t could do
>> > better about keeping the cache valid over time.
>>
>> test_expect_failure 'checkout gives cache-tree' '
>> =C2=A0 =C2=A0 =C2=A0 git checkout HEAD^ &&
>> =C2=A0 =C2=A0 =C2=A0 test_shallow_cache_tree
>> '
>>
>> ;-)
>
> Quick and dirty that passes that test.

I'm aware that Jeff's tackling at lower level, which retains
cache-tree for many more cases. But this patch seems simple and safe
to me, and in my experience this case happens quite often (or maybe I
tend to keep my index clean). Junio, any chance this patch may get in?

> -- 8< --
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 5bf96ba..c06287a 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -319,6 +319,10 @@ static void show_local_changes(struct object *he=
ad, struct diff_options *opts)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die(_("diff_se=
tup_done failed"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0add_pending_object(&rev, head, NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0run_diff_index(&rev, 0);
> + =C2=A0 =C2=A0 =C2=A0 if (!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES)) =
{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tree *tree =
=3D parse_tree_indirect(head->sha1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prime_cache_tree(&=
active_cache_tree, tree);
> + =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0}
>
> =C2=A0static void describe_detached_head(const char *msg, struct comm=
it *commit)
> @@ -493,13 +497,13 @@ static int merge_working_tree(struct checkout_o=
pts *opts,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 if (!opts->force && !opts->quiet)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 show_local_changes=
(&new->commit->object, &opts->diff_options);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (write_cache(newfd, active_cache, activ=
e_nr) ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0commit_locked_index(lock_fil=
e))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die(_("unable =
to write new index file"));
>
> - =C2=A0 =C2=A0 =C2=A0 if (!opts->force && !opts->quiet)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 show_local_changes=
(&new->commit->object, &opts->diff_options);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> -- 8< --
> --
> Duy
--=20
Duy
