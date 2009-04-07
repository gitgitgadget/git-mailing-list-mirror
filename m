From: Antriksh Pany <antriksh.pany@gmail.com>
Subject: Re: git diff bug?
Date: Tue, 7 Apr 2009 23:55:00 +0530
Message-ID: <e6cd6cf90904071125m3009c34dv9b9c037a98983405@mail.gmail.com>
References: <m2ocvdkyul.fsf@boostpro.com>
	 <20090404014527.GA13350@coredump.intra.peff.net>
	 <1BF9172A-BE91-4D1C-932A-EB9FD79BA402@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 20:26:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrG0W-0005Dl-UI
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 20:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760273AbZDGSZF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 14:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759625AbZDGSZE
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 14:25:04 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:39313 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758416AbZDGSZC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 14:25:02 -0400
Received: by ey-out-2122.google.com with SMTP id 4so37543eyf.37
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aWjFJJzjXwCQnjEWpVCdf/a0mPRxJS+QWuPyorqCP/A=;
        b=sXl6TmzIvjYRbBou3pN9qF9NLdOaP5A3WJ9kvErcwR3lc+bZSM1AgVp6WA4f+BGYho
         IVeKn/ri9fOs2RFuMPq4+WuYIvcIO9z2XZYNCNqNI6sb+I59ozNSsh8drEoxP8E0h+sq
         32ImyrW4IddGCWwk0GCyTBsipn8pSB8oePTZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CGpy+PzqaBE0eqZJAm5gi0QmGSBVrmtLDbtdsJAraJklTu2uXt/FzS26HqMmLHqwV7
         MTU8Js0OOtzglhia3R+ky2WUyfhDATfovX4SNxxKZJRMMAVuaCPDlDEpKaT67cFjw6CW
         +htgUWEuqq1kakm/DZ8+JYosggdLvlpq0xEb4=
Received: by 10.210.65.2 with SMTP id n2mr437354eba.80.1239128700382; Tue, 07 
	Apr 2009 11:25:00 -0700 (PDT)
In-Reply-To: <1BF9172A-BE91-4D1C-932A-EB9FD79BA402@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115976>

I believe you need to have only the line

*.el diff=3Del

in the .gitattributes file.

The part

[diff =3D "el"]
   xfuncname =3D ...

has to be in the git config file. The .git/config file would do for thi=
s.


On Mon, Apr 6, 2009 at 2:39 PM, David Abrahams <dave@boostpro.com> wrot=
e:
>
> On Apr 3, 2009, at 9:45 PM, Jeff King wrote:
>
>> On Fri, Apr 03, 2009 at 09:10:42PM -0400, David Abrahams wrote:
>>
>>> Please see
>>> http://github.com/techarcana/elisp/commit/63d672c296316c85690085930=
b05c642b88a9978#diff-2
>>>
>>> Note how the @@ ... @@ clauses are followed by text from the previo=
us
>>> line's comment. =A0Not sure, but this strikes me as a line-ending i=
ssue.
>>> custom.el was originally built on a linux machine; now I'm using a =
Mac.
>>
>> This is as designed. The original file ("git show e7dd7db") contains=
 (my
>> numbering seems different than what git produces; it is produced by =
"nl"
>> which is maybe treating some line endings differently earlier in the
>> file):
>>
>> =A0102 =A0 '(mm-attachment-override-types (quote ("text/x-vcard" "ap=
plication/pkcs7-mime" "application/x-pkcs7-mime" "application/pkcs7-sig=
nature" "application/x-pkcs7-signature" "image/*")) nil nil "
>> =A0103 =A0Added image/* to display attached images inline")
>> =A0104 =A0 '(mm-discouraged-alternatives (quote ("text/html" "text/r=
ichtext" "image/.*")) nil nil "
>> =A0105 =A0The documentation for this variable says it all")
>> =A0106 =A0 '(mm-inline-text-html-with-images t)
>> =A0107 =A0 '(muse-project-alist (quote (("WikiPlanner" ("~/plans" :d=
efault "index" :major-mode planner-mode :visit-link planner-visit-link)=
))))
>> =A0108 =A0 '(org-agenda-files (quote ("~/organizer.org")))
>>
>> The changed text in your diff starts on 108. So we show 105-107 as
>> context lines. The text after the @@ clause is the "function header"=
;
>> this is equivalent to "-p" in GNU diff. It's basically a guess about=
 the
>> most interesting context to show, and looks alphabetic characters th=
at
>> are left-aligned. In the case of lisp, it really isn't all that
>> interesting (and what looks so weird is that your file contains
>> a lot of
>>
>> =A0"\nSome text"
>>
>> so the text strings are all left-aligned. You can customize the rege=
x
>> used to guess at the function header. See "defining a custom
>> hunk-header" in "git help attributes".
>
> Hmm, so I tried sticking this .gitattributes in my repo
>
> =A0*.el =A0 diff=3Del
> =A0[diff "el"]
> =A0 =A0 =A0 =A0xfuncname =3D "^(\\(def[a-z]+ .+)$"
>
> and git diff barfed with
>
> =A0"el"] is not a valid attribute name: .gitattributes:2
> =A0"^(\\(def[a-z]+ is not a valid attribute name: .gitattributes:3
>
> What am I missing? =A0I tried googling, but from what turns up for me=
, it doesn't look like anyone else has ever tried to use this feature!
>
> TIA,
>
> --
> David Abrahams
> BoostPro Computing
> http://boostpro.com
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
