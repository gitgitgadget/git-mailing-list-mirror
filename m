From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Sat, 20 Mar 2010 01:21:00 +0100
Message-ID: <201003200121.02560.jnareb@gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <m3tyscjt7h.fsf@localhost.localdomain> <b4087cc51003190740h680b5dech4edd7a5000f180ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 01:21:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsmRR-0004cO-Or
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 01:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751Ab0CTAVT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 20:21:19 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:35838 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583Ab0CTAVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 20:21:16 -0400
Received: by bwz1 with SMTP id 1so496070bwz.21
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 17:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vxV8jq0ydLlBssZ0pT9zwTl4eNacSNKBDs5doPXNXV0=;
        b=l18nGcE5eB48etvGSiBzA9DWYMN2V/3rVGZfnVfdVFyA5dU+BGac4Il2P3O4K/nm5U
         p4m6/FR+gmj8Jq5iOqKQziHMyFR6VoUdjCduZhtUEK4b4D3DB5GdyKhr0WSiP1xyMzXF
         jiuSzm+FgtZ8SoGP/3hq4wIdBv8aoEwbkNXCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZE2rfz43M0jpmRkXZrimsoum7svF6LeasXmEG2S/pVhP4HXBIKrfHG4kS0d3YglMu+
         EYLKzJvU1dbnEjL1CAOlceMtw1juCVsTPSihcd/aIVhgBPLUznNg8/+XsqeI0QRjsgkw
         Rd25b50d+isulSSPnic0s5/vJP/cCkrp4QRCI=
Received: by 10.204.38.65 with SMTP id a1mr3026340bke.168.1269044474335;
        Fri, 19 Mar 2010 17:21:14 -0700 (PDT)
Received: from [192.168.1.13] (abve2.neoplus.adsl.tpnet.pl [83.8.202.2])
        by mx.google.com with ESMTPS id 16sm1028682bwz.13.2010.03.19.17.21.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 17:21:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <b4087cc51003190740h680b5dech4edd7a5000f180ee@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142665>

On Fri, 19 Mar 2010, Michael Witten wrote:
> On Fri, Mar 19, 2010 at 08:08, Jakub Narebski <jnareb@gmail.com> wrot=
e:

>> This is non-solution to non-problem.
>>
>> First, the user.name and user.email does not need to be name and ema=
il
>> from some email account. =C2=A0It might be some "canonical name" and
>> "canonical email".
>=20
> The vast majority of patches come in through email; the git tools
> expect the user.name and user.email to reflect physical email account
> information.
>=20
> You would be correct if it were not for the fact that git currently
> conflates identity and current email system.

It is not true.  From the git-config(1) manpage, the description (meani=
ng)
of user.name and user.email is:

  user.email::
        Your email address to be recorded in any newly created commits.
        Can be overridden by the 'GIT_AUTHOR_EMAIL', 'GIT_COMMITTER_EMA=
IL', and
        'EMAIL' environment variables.  See linkgit:git-commit-tree[1].

  user.name::
        Your full name to be recorded in any newly created commits.
        Can be overridden by the 'GIT_AUTHOR_NAME' and 'GIT_COMMITTER_N=
AME'
        environment variables.  See linkgit:git-commit-tree[1].
=20
As you can see there is nothing about email, and physicsl email account=
=2E

It is true that git-send-email asks about the "From" email address to
send email from with user.name + user.email as default value...
unless either sendemail.from or --from option is used. =20
[See also below].

>> Second, there are (I think) two main sources of 'unstability' in
>> (name,email) pairs, namely A) misconfigured git (when fetching/pushi=
ng
>> using git itself), B) wrong name in email etc. (when sending patches
>> via email, 80% of patches in Linux kernel case).
>>
>> In the case of misconfigured git (case A) using UUID wouldn't help,
>> and only make it worse (you would have to configure the same UUID on
>> each machine). =C2=A0What would help here is for git to be more stri=
ct and
>> perhaps forbid (some of) autogenerated names and emails.
>=20
> The uuid string would be typed pretty much only during configuration;
> from there, it's basically just handled by the git tools. Hence, the
> uuid can indeed suffer from typos, but the name/email pair can suffer
> from not only typos but also real life name changing and email accoun=
t
> switching.

You do not need (in theory at least) to change user.name nor user.email
with real life name changing (like marriage or adoption) and email=20
account switching.

[...]
>> In the case of sending patches via email, you can use in-body 'From:=
'
>> to provide (name,email) part that is different than account used to
>> send email.
>=20
> That's a good solution that I've considered, except for 2 reasons:
>=20
>     * It involves much more opportunities for typos and/or the
>       configuration of a non-git tool for a git-specific purpose.
>=20
>     * Many if not most email services will refuse to send messages
>       with forged/spoofed email addresses.

Actually git-send-email would automatically add in-body "From:" header
if it is different from the "From:" address for email, and git-am would
automatically prefer in-body "From:" over sender (in-header "From:")
for authorship information.

Sender can be different from author of the patch, there is no problem
with that.

What git can improve here (and perhaps already does it) is handling of
non-ASCII characters in name (e.g. when commit message does not contain
non US-ASCII letters, but user.name does).  Perhaps it got corrected
(improved) already.


P.S. Backward compatibility (older git-am) would probably require
UUID in the form of canonical name+email, and use of in-body "From:"
header to pass this UUID when sending patches.

>> In the case of UUID you would need the same: some way to
>> provide UUID in patch (in email).
>=20
> Yes, but that's automated by tools like git's format-patch. Not using
> something like format-patch or some other git interface is an
> 'out-of-band' communication and that author has essentially chosen no=
t
> to care about his identity.
>=20
> The use of the uuid field and allowing git tools to handle it is just
> a way to give a person who does care about his identity to keep it
> consistent.

git-send-email *already* automatically deals with sender !=3D author.

[...]
>> What could help in both cases is .mailmap being used (perhaps on
>> demand) in more git commands. =C2=A0See Documentation/mailmap.txt
>> or e.g. git-shortlog(1) manpage. =C2=A0It is quite advanced tool for
>> correcting mistakes (it can correct *both* user name, which is
>> most common usage, but also email address).
>=20
> The disadvantage here is that it centralizes identity management and
> it is more demanding because the name/email pair is quite unstable.

How in-tree .mailmap file (in-tree like .gitignore and .gitattributes)
is *centralized identity management*?  It is as distributed as git
repositories are.

On the other hand user.uuid is not distributed; for security reasons
config is not transferred.

[...]
> [...], and with
> some clever encoding some statistics gathering programs could
> (possibly) run more efficiently.

Well, I guess it is statistics that dominates, not id part.  Such
tools shoud simply take .mailmap into account (unless they rely on
git for that.).

--=20
Jakub Narebski
Poland
