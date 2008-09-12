From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: CGit and repository list
Date: Sat, 13 Sep 2008 01:20:50 +0200
Message-ID: <8c5c35580809121620x2de1828cq498b3709f7b0bd1b@mail.gmail.com>
References: <19449377.post@talk.nabble.com>
	 <20080912145804.GF10544@machine.or.cz>
	 <8c5c35580809120810s69e8ec4fnf2a629d4cf575901@mail.gmail.com>
	 <200809121812.40920.johan@herland.net>
	 <20080912224817.GF10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>,
	"=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <hoegsberg@gmail.com>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Sep 13 01:22:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeHxh-0001yr-40
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 01:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817AbYILXUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 19:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755217AbYILXUx
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 19:20:53 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:1917 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbYILXUw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 19:20:52 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1000269wfd.4
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 16:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JJ+fXNOc1g6aPoMcPPcfHL9cJmJf7EMFia3eyc8kezg=;
        b=i+ovblNClYmc+ssnT4pcvCXc6cj19rtzK839G19OCDfXOxRwR9falg0zlNsIEUR96R
         NPxbKohTf8HavUeFgM95NsWENcuwzrOWKr5DSSZh4WrGewwcIX9bJAbSgquda3SQ6SUa
         dhwbx2Nvu+h7WECziPdzxH3KX+RtMa5KdPQbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=c1uGEpVRiSwWAmrv7IR0plwW3FWHIvWC85YaccWsMp9qKK/gJBl4mHrXUctHExdGyV
         nOxmjnyXow1/JfFJLPlpRS+NAhDqkeiuEFzd94sewLDhc7F48oBlf3KZa4Y2jlKgPii7
         eM0Q3pkPpQUz7NyB6Z+lneeMebluwZjR8IDr8=
Received: by 10.114.241.15 with SMTP id o15mr3926479wah.164.1221261651025;
        Fri, 12 Sep 2008 16:20:51 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Fri, 12 Sep 2008 16:20:50 -0700 (PDT)
In-Reply-To: <20080912224817.GF10360@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95786>

On Sat, Sep 13, 2008 at 12:48 AM, Petr Baudis <pasky@suse.cz> wrote:
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
> still quite a pain.

I guess I could add support for something like

  scan-paths=/pub/git

in cgitrc (and optionally store the result of the scan as another
cgitrc-file in the cache directory). Would that improve things for
you?


> Unfortunately, the recommended RewriteRule is not working - it does not
> play well together with query parameters cgit is using, so e.g. browsing
> past commits does not work. What RewriteRule should I use instead?

On hjemli.net I used to specify "virtual-root=/git" in cgitrc combined
with this rule in /etc/apache/httpd.conf

  RewriteRule ^/git/(.*)$   /cgit/cgit.cgi?url=$1  [L,QSA]


But currently I'm running the tip of the wip-branch (which has support
for PATH_INFO) on hjemli.net , so I've removed the "virtual-root" from
cgitrc and the rewriterule from httpd.conf and just use this instead:

  ScriptAlias /git /var/www/htdocs/cgit/cgit.cgi

hth,
larsh
