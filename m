From: Michael Witten <mfwitten@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 18:33:56 -0600
Message-ID: <b4087cc51001291633l68760880i340d12e865641077@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <hjvgs1$rep$1@ger.gmane.org> 
	<ron1-953427.13240429012010@news.gmane.org> <fabb9a1e1001291328s1df443d6jdf0501cda17072de@mail.gmail.com> 
	<7vmxzwh906.fsf@alter.siamese.dyndns.org> <ron1-6C7BCB.14122429012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 01:34:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb1I8-0007BX-PG
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 01:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab0A3AeS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 19:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754268Ab0A3AeS
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 19:34:18 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:60338 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890Ab0A3AeR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 19:34:17 -0500
Received: by ewy19 with SMTP id 19so50079ewy.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 16:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/0Lcy58MOlLKe+z/LsftiOY66vA0A28GDAntxI9jGVc=;
        b=SXhUcTbWWKNaxVQdE6MAW4hM5cwLNNl174Jr8JWwvtruWMdvvwdXV+Qxrow0axQFaE
         0UKKGmhsZuQ13SFQSjofGab4wchf7bhPlCLHE+QYtJic9sdO9t7PS9d+V8d5AYIxYgVF
         HAtF+D9HAnfIeDmzu7TB8QlN0jXnNVVR2iQcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xuWtxMlABi8IIMOCiRGddnTTxDPtBSwyzeoAYrnmKcBj+vgsnhIgSybc74nopIRlll
         okIevnS4SUCyh8KpqWxDd+WV0JzUjJmcFDaVwb8on3Say1L8wCMBihAWCrkr25UaiGuI
         R2dVbC2mkjzj2f+DMzFoYKFp8TI2FWU2BZtD0=
Received: by 10.213.103.134 with SMTP id k6mr1624795ebo.2.1264811656231; Fri, 
	29 Jan 2010 16:34:16 -0800 (PST)
In-Reply-To: <ron1-6C7BCB.14122429012010@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138409>

On Fri, Jan 29, 2010 at 4:12 PM, Ron Garret <ron1@flownet.com> wrote:
> In article <7vmxzwh906.fsf@alter.siamese.dyndns.org>,
> =A0Junio C Hamano <gitster@pobox.com> wrote:
>
>> Sverre Rabbelier <srabbelier@gmail.com> writes:
>>
>> > On Fri, Jan 29, 2010 at 22:24, Ron Garret <ron1@flownet.com> wrote=
:
>> >> Yes, I read that. =A0But what I'm trying to do is not just *look*=
 at the
>> >> history, I want to restore my working tree to a previous version.=
 =A0The
>> >> "Exploring History" section of the docs doesn't say how to do tha=
t.
>> >
>> > Do you want to restore your working tree only, or also throw away =
the
>> > history? If the former, you could look at 'git revert',...
>>
>> I think he wanted to check paths out of a commit and the set of path=
s
>> happened to be "everything".
>>
>> IOW, "checkout $commit ."
>
> Yes!!! =A0That's it exactly!

However, that updates the index and doesn't delete files that didn't
exist in $commit, and you said earlier that you don't want to update
the index (though perhaps you didn't really know what you wanted
there).

My idea:

Isn't the difference between 'checkout' and 'reset' almost essentially
a matter of whether the branch reference (HEAD), index, and tree are
modified? Couldn't these commands be merged into one command or make
use of one command?

Rather than relying on flags like --hard, --soft, and --mixed, why not
*also* provide flags for specifying at a finer granularity what is
desired for the index, working tree, and HEAD.

Then:
    git checkout $commit
does a lot of its work through something like:
    git update --index --tree --detach $commit

Also:
    git checkout $commit $f
translates:
    git update --index --tree --keep-tracked-files $commit $f

Also:
    git reset [--mixed] $commit
translates:
    git update --index --head $commit

Also:
    git reset --soft $commit
translates:
    git update --head $commit

Also:
    git reset --hard $commit
translates:
    git update --index --tree --head $commit

And so on.

In fact, with --no-* flags, you could modify 'reset' and 'checkout'
commands from their defaults. So, to update all of the paths
(including deleting tracked files not in $commit), but keep the index
untouched, we have:

    git checkout --no-update-index --no-update-keep-files $commit .

Of course, you might as well just use the hypothetical 'update'
command directly:

    git update --tree $commit .

Sincerely,
Michael Witten
