From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Local clones aka forks disk size optimization
Date: Thu, 15 Nov 2012 09:14:10 +0530
Message-ID: <CAMK1S_ioQQWXaOO8Na=7M4QhaaUNQ8ySVM-E_2bk6m4TyvRpeA@mail.gmail.com>
References: <CALZVapmG+HL0SQx8zx=Cfz5pWv84hJq90x-7VdjA0m2Z4dC34A@mail.gmail.com>
	<CALZVapmO61d8yXfXXGx6Qc444ka+8n7HabuNRt0rJdE5qy_7aQ@mail.gmail.com>
	<CAH5451nW2esQR8XaAttT3tYJZEw1Nj3OEMgkHsMZrZDxhcRXHw@mail.gmail.com>
	<CALZVap=kOwOpxeu8+_+5uQYZz3GNC8Ep_JeK7WCQHtu+Hn3rUw@mail.gmail.com>
	<CAH5451m4saVa7-NLbVbXp7q8ca5_0N4FLk3wYaqxLT=AE5frbw@mail.gmail.com>
	<CALZVapmBM78UtjAiNm2VoeWuetCiyxN70mTxbG14SQh5a5RCeQ@mail.gmail.com>
	<CAH5451=Tk=zjkYbK0720VBkAA12VRCAE_Dx8bBkoXba60ho8AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Javier Domingo <javierdo1@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 04:44:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYqNP-00064O-CM
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 04:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423556Ab2KODoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 22:44:13 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:63473 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992461Ab2KODoN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 22:44:13 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so950349lag.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 19:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=g2HI/yLCdtoehJOFRdRmBZUtm34p5fZkxLs9TYNpMEc=;
        b=OsZoXFldztoiVg6SKkasu83cL4s3VeKhD75WqbvMi/gTIvHJlMmP5kVHSEsHXgg8Mo
         dNt4Cerxk0u+5YoNKsc3MDktS8aBkqfKKEejTSsCS6AUlphikokp3QEzhq0kK7T/wUhv
         nbXf9xg00LpGUHDWCFa/ZeK4QClVbStxq80L/YyfGOCacUn/fEaq4OwfEjrEHCfCyPnp
         vEc34ncRP226XAwc8ZXDKDTo0f1zzpndsKeHNovnhoJqhgVBQmXfwGjQwSXhzpPlqGUn
         SYMy6tp1pa3ETwoZHMwI6j9DpdbdmMzb2fk0ZbMdk+h9mcm9accvvuumSyW7QsDrv6Rv
         WYjA==
Received: by 10.152.114.65 with SMTP id je1mr21168059lab.33.1352951051053;
 Wed, 14 Nov 2012 19:44:11 -0800 (PST)
Received: by 10.112.113.103 with HTTP; Wed, 14 Nov 2012 19:44:10 -0800 (PST)
In-Reply-To: <CAH5451=Tk=zjkYbK0720VBkAA12VRCAE_Dx8bBkoXba60ho8AA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209795>

On Thu, Nov 15, 2012 at 7:04 AM, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> On 15 November 2012 12:15, Javier Domingo <javierdo1@gmail.com> wrote:
>> Hi Andrew,
>>
>> Doing this would require I got tracked which one comes from which. So
>> it would imply some logic (and db) over it. With the hardlinking way,
>> it wouldn't require anything. The idea is that you don't have to do
>> anything else in the server.
>>
>> I understand that it would be imposible to do it for windows users
>> (but using cygwin), but for *nix ones yes...
>> Javier Domingo
>
> Paraphrasing from git-clone(1):
>
> When cloning a repository, if the source repository is specified with
> /path/to/repo syntax, the default is to clone the repository by making
> a copy of HEAD and everything under objects and refs directories. The
> files under .git/objects/ directory are hardlinked to save space when
> possible. To force copying instead of hardlinking (which may be
> desirable if you are trying to make a back-up of your repository)
> --no-hardlinks can be used.
>
> So hardlinks should be used where possible, and if they are not try
> upgrading Git.
>
> I think that covers all the use cases you have?

I am not sure it does.  My understanding is this:

'git clone -l' saves space on the initial clone, but subsequent pushes
end up with the same objects duplicated across all the "forks"
(assuming most of the forks keep up with some canonical repo).

The alternates mechanism can give you ongoing savings (as long as you
push to the "main" repo first), but it is dangerous, in the words of
the git-clone manpage.  You have to be confident no one will delete a
ref from the "main" repo and then do a gc or let it auto-gc.

He's looking for something that addresses both these issues.

As an additional idea, I suspect this is what the namespaces feature
was created for, but I am not sure, and have never played with it till
now.

Maybe someone who knows namespaces very well will chip in...
