From: Amos King <amos.l.king@gmail.com>
Subject: Re: [PATCH 2/2] Allow http authentication via prompt for http push.
Date: Thu, 19 Mar 2009 14:02:30 -0500
Message-ID: <d8c371a80903191202v6fb974f4t2321761d0cf21a70@mail.gmail.com>
References: <d8c371a80903190812w59febbd3qc6bc3d70ce85f76e@mail.gmail.com>
	 <alpine.DEB.1.00.0903191755270.6357@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 20:04:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkNXE-00030b-Sy
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 20:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbZCSTCg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 15:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbZCSTCg
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 15:02:36 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:65512 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbZCSTCf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 15:02:35 -0400
Received: by qyk16 with SMTP id 16so874877qyk.33
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PGSx9MLwYsSWFDM7XQrHFhjOKq5Wpzwu/5RtPxqrz30=;
        b=LuiOdR7sNdcNF3dLpZv4X3qs1Y5mAitVtVQOC0anvd8kpGWaVuTCruB8d0Uce48TW5
         b/QreQ1Z7VuFGA9ox8Dy6d9znmVJmHiSUboJVkbIELGm6oFINruUUAEvc3YLE10917w9
         RGpK7IhxuB9thXYSXXwhpdvrQejAIKTCptLPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Fg6a0SMzpGQJg4OSk+umHrkCiXYGQXh3J2XXYt8VMlqJFgDlJxrr0tSK1s0mFnY1Hj
         +wTEa2lOb2GsIoPci3jGZRtYtJsmyISIXMyBLrIQtLKcObFrsPCAtcRQJpSjnFqx3Ra4
         6d4YRFi+BKl12fHHRU7XiPERuZB9OWk0XQLbM=
Received: by 10.229.100.14 with SMTP id w14mr1758083qcn.48.1237489350327; Thu, 
	19 Mar 2009 12:02:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903191755270.6357@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113807>

The issue with calling it remote is that it conflicts with the remote
struct that is need for http_init, and is used in the rest of the
code.  So do you want me to make this small impact change or a larger
and more broad sweeping change by changing the name of the other
remote.  I don't believe fake is a better name.  I would hope that at
some point the 'repo' struct would go away and we can make http_push
work like all the other remote commands.

I also believe that 'out' is the correct word.  It was not a typo, and
I appreciate your suggestion of assuming that I can't spell just
because I used a word that you didn't understand.  I'm not building
OUR authorization.  I am building OUT authorization.  Have you heard
of building something out?  Or even fleshing something out?

I appreciated your first responses to my other patch.  Even if your
tone was that of a person with low self-esteem who needs to pick
unimportant details apart in order to stroke their own ego.  Instead
of responding in the same tone I thought I would respond nicely and
get your feedback.  Responses like your first one don't cause people
to want to continue to contribute to the community.

I have a great idea.  Why don't you try using the 'nice' tense in your
next email instead of the high and mighty 'ass-hole' tense.  Then I
will gladly not use past tense in my commit messages, and others might
respond more positively to your criticisms.

=46iek Dich,
Amos

On Thu, Mar 19, 2009 at 11:59 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 19 Mar 2009, Amos King wrote:
>
>> There is now a faux remote created in order to
>> be passed to http_init.
>>
>> Signed-off-by: Amos King <amos.l.king@gmail.com>
>> ---
>> =C2=A0http-push.c | =C2=A0 11 ++++++++++-
>> =C2=A01 files changed, 10 insertions(+), 1 deletions(-)
>>
>> diff --git a/http-push.c b/http-push.c
>> index 9ac2664..468d5af 100644
>> --- a/http-push.c
>> +++ b/http-push.c
>> @@ -2195,7 +2195,16 @@ int main(int argc, char **argv)
>>
>> =C2=A0 =C2=A0 =C2=A0 memset(remote_dir_exists, -1, 256);
>>
>> - =C2=A0 =C2=A0 http_init(NULL);
>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* This is a faked remote so that http_init can
>> + =C2=A0 =C2=A0 =C2=A0* get the correct data for builidng out athori=
zation.
>> + =C2=A0 =C2=A0 =C2=A0*/
>
> You might want to pass this through aspell ;-) =C2=A0Altough it will =
not
> suggest 'out ->our', I guess...
>
>> + =C2=A0 =C2=A0 struct remote *remote;
>> + =C2=A0 =C2=A0 remote =3D xcalloc(sizeof(*remote), 1);
>> + =C2=A0 =C2=A0 ALLOC_GROW(remote->url, remote->url_nr + 1, remote->=
url_alloc);
>> + =C2=A0 =C2=A0 remote->url[remote->url_nr++] =3D repo->url;
>> +
>> + =C2=A0 =C2=A0 http_init(remote);
>
> Would 'fake' not be a more appropriate name than 'remote'?
>
> That would also make the patch 1/2 rather unnecessary (I also have to
> admit that I do not find 'repo' a better name, as we have a repositor=
y
> both locally and remotely, and this _is_ the remote repository, not t=
he
> local one).
>
> Ciao,
> Dscho
>
>



--=20
Amos King
http://dirtyInformation.com
http://github.com/Adkron
--
Looking for something to do? Visit http://ImThere.com
