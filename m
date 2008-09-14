From: "=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@bitplanet.net>
Subject: Re: CGit and repository list
Date: Sun, 14 Sep 2008 13:14:03 -0400
Message-ID: <59ad55d30809141014x2160d50dqb8ac20b4c108b4e1@mail.gmail.com>
References: <19449377.post@talk.nabble.com>
	 <20080912145804.GF10544@machine.or.cz>
	 <8c5c35580809120810s69e8ec4fnf2a629d4cf575901@mail.gmail.com>
	 <200809121812.40920.johan@herland.net>
	 <20080912224817.GF10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Lars Hjemli" <hjemli@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Sep 14 19:15:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KevBu-0001wF-Jd
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 19:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbYINROL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 13:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbYINROI
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 13:14:08 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:62466 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064AbYINROF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 13:14:05 -0400
Received: by an-out-0708.google.com with SMTP id d40so164397and.103
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 10:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=XVSVDq2Y9jba7cgm8eCPi6CzhhsWXuG4a4m4mOy2IRs=;
        b=BtzAq7URGXuqrbrP9OwDspH5SAkZ8fzn6kM4MSBDQGUFOHaV33NWPDIZLxwmL+hxIo
         BZdlpZ13BEb/6PC30qdhirg21JVfdhgacJ4M8A+6W0uHFlEW16zb0ziwQ9eEkjo7XPCh
         CFZ0VvnuextQ/GCdw2WOcNZMHily+RFBhlWRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=mMoMXIZJ4NOgdl0CtYZ7IkbXt2tBRUqd7gTOI1NtMST3K7IvUz/4kWp1gY2YEFpM5c
         5QmUJGvg6YnUK+XUl8CYBPbFYj2n1unmGAo4chPc8+fQQrQZq0uouLZYRnEmuw8Pzyi4
         BrOcRZokx7JZDyadUulrkDD1P5gwTi/dEiXaQ=
Received: by 10.100.8.4 with SMTP id 4mr7547238anh.38.1221412443864;
        Sun, 14 Sep 2008 10:14:03 -0700 (PDT)
Received: by 10.100.109.2 with HTTP; Sun, 14 Sep 2008 10:14:03 -0700 (PDT)
In-Reply-To: <20080912224817.GF10360@machine.or.cz>
Content-Disposition: inline
X-Google-Sender-Auth: 8677731ad072727d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95848>

On Fri, Sep 12, 2008 at 6:48 PM, Petr Baudis <pasky@suse.cz> wrote:
> On Fri, Sep 12, 2008 at 06:12:40PM +0200, Johan Herland wrote:
>> On Friday 12 September 2008, Lars Hjemli wrote:
>> > On Fri, Sep 12, 2008 at 4:58 PM, Petr Baudis <pasky@suse.cz> wrote:
>> > > it seems that cgit
>> > > requires all the repositories explicitly listed in the config file.
>> > > Do you plan to remove this limitation in the future?
>> >
>> > Not really, I'd rather add another command (or a commandline option)
>> > to generate an include-file for cgitrc by scanning directory-trees
>> > for git repos. I've CC'd Kristian since I believe he's got such a
>> > script running for freedesktop.org; if so, maybe it could be
>> > included/used as basis for something similar in cgit?
>>
>> Here's a script I wrote for locating repos and generating repo
>> lists/configs for cgit, gitweb and hgwebdir (yes, this handles hg repos
>> as well). It works either as a CGI script (producing a list of detected
>> repos in HTML format), or from the command-line. It's only been tested
>> on an experimental DVCS server at $dayjob, so you might have to change
>> things to make it work in your scenario.
>>
>> If there is interest in this, I can create a public repo and we can keep
>> improving on it.
>
> Thanks. The script was a bit more scary than I thought, but in the end I
> managed to generate something. There are trailing dots in project names,
> but I'm not going to waste time on that anymore - this has long gone
> over the 20 minutes I originally alotted the project anyway; I hope cgit
> will gain a builtin capability for this in the future, since this is
> still quite a pain. Attached is a random patch for your script I had to
> use, FWIW.

The script we're using on freedesktop.org is something like this:

  http://people.freedesktop.org/~krh/find-repos.sh

which isn't too scary.  We run it from a cron script, every ten
minutes or so.  It's much better than  rescanning all the dirs every
time somebody requests the repo listing (we have a lot of repos, check
cgit.freedesktop.org).  We have no need for cgit to to this
automatically on every request, and I don't see us using that feature
if it gets implemented.

cheers,
Kristian
