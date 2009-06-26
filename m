From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 4/8] gitweb: (gr)avatar support
Date: Sat, 27 Jun 2009 00:08:02 +0200
Message-ID: <cb7bb73a0906261508s47e8834fuc9b3313bd9f127ce@mail.gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906262142.28845.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 00:08:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKJah-0005er-2b
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 00:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbZFZWIE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2009 18:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbZFZWIC
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 18:08:02 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:47422 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbZFZWIB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2009 18:08:01 -0400
Received: by bwz9 with SMTP id 9so2275895bwz.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 15:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=w6OlFx4KuOmOgjRUpPWPCky063NejS41eOHh49IpadM=;
        b=FzwQL7gPx41WjUqFDb/seLhLjbqcyDmYCXZ8GHLZsjSNgI9GEmsxXTobbOHW+Pb8Fc
         XpUjRcvDovCob5Q6l+ohyX8HktZmv25oIT81AFhKWUd5pw7VzC2y+/bqeSkE3uDE+bcJ
         4MzcC68fxiB+beEus0NmVcVN/6mvEK6qC4WiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OQH9Sy6u58ZhHB/6Cdgg9sKZUelb52YGhAL+p/2mldGWNKdqZJh3yZJQuADN/M/zXV
         KQawWvxDKCF58TBNz4FE8k05wnSK6ZNDEMhe0vHkjIXy4JnHkyGQZ0y1g1eYqIYXJ3ji
         rL0XjnarE0R9qXAUzzswye2ZLSHIOP6tLXrZA=
Received: by 10.204.98.195 with SMTP id r3mr1904183bkn.128.1246054082730; Fri, 
	26 Jun 2009 15:08:02 -0700 (PDT)
In-Reply-To: <200906262142.28845.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122328>

2009/6/26 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 25 June 2009, Giuseppe Bilotta wrote:
>
>> Introduce avatar support: the featuer adds the appropriate img tag n=
ext
>> to author and committer in commit(diff), history, shortlog and log v=
iew.
>
> You forgot about 'tag' view (but I guess it would be done in next
> version of this patch series).

Indeed, it's automatically addressed because patch view follows the ref=
actoring.

> There is also 'feed' action (Atom and RSS formats), but that is certa=
inly
> separate issue, for a separate patch.

I'm not entirely sure we want avatars there.

> You would _probably_ want to squash the following, just in case:

[snip]

> But even if you don't squash it, please run t9500 with this patch
> applied, to catch Perl errors and warnings.

I'll squash it in.

> Sidenote: Gravatar API description[1] mentions 'identicon', 'monsteri=
d',
> 'wavatar'. =A0There are 'picons' (personal icons)[2]. =A0Also avatars=
 doesn't
> need to be global: they can be some local static image somewhere in w=
eb
> server which serves gitweb script, or they can be stored somewhere in
> repository following some convention.
>
> Current implementation is flexible enough to leave place for extendin=
g
> this feature, but also doesn't try to plan too far in advance. =A0YAG=
NI
> (You Ain't Gonna Need It).
>
> [1] http://www.gravatar.com/site/implement/url
> [2] http://www.cs.indiana.edu/picons/ftp/faq.html

The forthcoming series has picons provider and gravatar fallback;
however, we might want to have some way to make the gravatar fallback
configurable.

>> + =A0 =A0 # To enable system wide have in $GITWEB_CONFIG
>> + =A0 =A0 # $feature{'avatar'}{'default'} =3D ['gravatar'];
>> + =A0 =A0 # To have project specific config enable override in $GITW=
EB_CONFIG
>> + =A0 =A0 # $feature{'avatar'}{'override'} =3D 1;
>> + =A0 =A0 # and in project config gitweb.avatar =3D gravatar;
>> + =A0 =A0 'avatar' =3D> {
>> + =A0 =A0 =A0 =A0 =A0 =A0 'override' =3D> 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 'default' =3D> ['']},
>
> Note that to disable feature with non-boolean 'default' we use empty
> list [] (which means 'undef' when parsing, which is false); see
> description of features 'snapshot', 'actions'; 'ctags' what is strang=
e
> uses [0] here... =A0Using [''] is a bit strange; and does not protect
> you, I think.

Using an empty string (or 0 like ctags do) is nice because it spares
the undef check you mention later on, and since empty strings and 0
evaluate to false in Perl, it's a good way to handle it. Moreover, any
string which is not an actual provider would result in no avatars.
More about this later.

>> +# check if avatars are enabled and dependencies are satisfied
>> +our ($git_avatar) =3D gitweb_get_feature('avatar');
>
> IMPORTANT!!!
>
> Because you now allow possibility that there can be other avatars
> than those provided by Gravatar, you should explain in comment
> what this check below does (e.g. something like "load Digest::MD5,
> required for gravatar support, and disable it if it does not exist"),
> so people adding (in the future) support for other kind of avatars
> would know that they should put similar test there, if needed.

I'll make the check and subsequent switch a little cleaner.

>> +if (($git_avatar eq 'gravatar') &&
>> + =A0 !(eval { require Digest::MD5; 1; })) {
>> + =A0 =A0 $git_avatar =3D '';
>> +}
>
> Here you would have to protect against $git_avatar being undefined...
> but you should do it anyway, as gitweb_get_feature() can return
> undef / empty list.

Using '' as defalt instead of [] shields me from this problem, and
works properly for boolean checks.

> This might be good enough starting point, but I wonder if it wouldn't
> be a better solution to provide additional column with avatar image
> when avatar support is enabled. =A0You would get a better layout in
> a very rare case[3] when 'Author' column is too narrow and author is
> info is wrapped:
>
> =A0[#] Jonathan
> =A0H. Random
>
> versus in separate columns case:
>
> =A0[#] | Jonathan
> =A0 =A0 =A0| H. Random
>
> But this is a very minor problem, which can be left for separate patc=
h.
>
> [3] unless you use netbook or phone to browse...

I had considered going this way, but it made the code somewhat more
complex so I went for the simpler solution. I'll look into putting it
in separate cells further on.


--=20
Giuseppe "Oblomov" Bilotta
