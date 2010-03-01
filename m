From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb problem?
Date: Mon, 01 Mar 2010 05:40:06 -0800 (PST)
Message-ID: <m37hpwma9u.fsf@localhost.localdomain>
References: <m34ol0wmze.fsf@winooski.ccs.neu.edu>
	<m3bpf8mj5k.fsf@localhost.localdomain>
	<m3zl2suun5.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Mon Mar 01 14:40:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm5rB-00081Z-3p
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 14:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab0CANkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 08:40:14 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:52409 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab0CANkM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 08:40:12 -0500
Received: by fg-out-1718.google.com with SMTP id d23so904245fga.1
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 05:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=C6jBDG3I2jOUTQPQrEokdgoX5kPZq91H03nBOyqugio=;
        b=UFfGF7uRY+PTEfBARpDa7IqYqqJ3bHe57djlHakO4tyNs8ghCvvno9416vrYbXUsJ6
         cE7I1oQ2Tvz5hEtc0xREO/ovJHnbn9W9bDtj/iaRNgBxN90WgL7FOQ6HTesUuC8bO6wN
         awg4dNCt0DMBiWzOPVamWDgRWJ9QON/imqTIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=yCXvWqZUiDz5jAbYUF3ySzZFGVdvyLb1+XqfrWVHDcgvWfLv3gBiaaS8150341LyRz
         Nghju8Gg2JBSi+aPp4Pmj3c5h1F5lftvXyoPB1sDH+wU7Umu594DUh1az13noIoA5Cmi
         lGwMKwT/JJ+p5MMCokn6F/ZdrFjnXD5Rq0w5M=
Received: by 10.103.81.35 with SMTP id i35mr3543093mul.42.1267450810198;
        Mon, 01 Mar 2010 05:40:10 -0800 (PST)
Received: from localhost.localdomain (abwj97.neoplus.adsl.tpnet.pl [83.8.233.97])
        by mx.google.com with ESMTPS id y37sm16926466mug.23.2010.03.01.05.40.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 05:40:06 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o21DdQqZ024040;
	Mon, 1 Mar 2010 14:39:36 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o21Dd9TG024033;
	Mon, 1 Mar 2010 14:39:09 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m3zl2suun5.fsf@winooski.ccs.neu.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141320>

Eli Barzilay <eli@barzilay.org> writes:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Eli Barzilay <eli@barzilay.org> writes:
>>
>>> Whenever I view the toplevel gitweb page (running as a cgi script
>>> under apache), but not when in a specific repo, I get this in my error
>>> log:
>>> 
>>> gitweb.cgi: Use of uninitialized value $git_dir in concatenation (.) or string at /home/git/gitweb/gitweb.cgi line 2065.
>>> fatal: error processing config file(s)
>>> gitweb.cgi: Use of uninitialized value $git_dir in concatenation (.) or string at /home/git/gitweb/gitweb.cgi line 2221.
>>> gitweb.cgi: Use of uninitialized value $git_dir in concatenation (.) or string at /home/git/gitweb/gitweb.cgi line 2218.
[...]
>>> Looking at the source, the last two line numbers are in
>>> `git_get_project_config' -- so my guess is that the code is trying to
>>> get the options from the repository config file even when showing the
>>> toplevel page.  Based on this, and also guessing that $git_dir is
>>> unset when viewing the toplevel page, I added
>>> 
>>> 	return unless (defined $git_dir);
>>> 
>>> to the top (of the `git_get_project_config' function), and I get no
>>> warnings and everything works as it should.

BTW. the first line number is in git_cmd invoked (called) from
git_get_project_config.

[...]
> No, that's not it.  I've tracked all calls to
> `git_get_project_config', and the two offending calls are the ones in
> `feature_snapshot' and `feature_avatar'.  I then verified that
> commenting out these two lines in my config
> 
>   $feature{'snapshot'}{'override'} = 1;
>   $feature{'avatar'}{'override'} = 1;
> 
> avoids the calls -- and the comments indicate that it should be fine
> to do that.

Ah, now I have found it.  This is a bug in gitweb.

The problem is in the following fragment:

  # path to the current git repository
  our $git_dir;
  $git_dir = "$projectroot/$project" if $project;

  # list of supported snapshot formats
  our @snapshot_fmts = gitweb_get_feature('snapshot');
  @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);

For the toplevel gitweb page, which is the list of projects, $project
is not defined, therefore $git_dir is neither.  gitweb_get_feature()
subroutine calls git_get_project_config() if project specific override
is turned on... but we don't have project here.

There are (at least) three possible solutions:

1. Harden gitweb_get_feature() so that it doesn't call
   git_get_project_config() if $project (and therefore $git_dir) is not
   defined; there is no project for project specific config.

2. Harden git_get_project_config() like you did in your fix, returning
   early if $git_dir is not defined.

3. Harden git_cmd() so that it doesn't add "--git-dir=$git_dir" if
   $git_dir is not defined, and change git_get_project_config() so that
   it doesn't even try to access $git_dir if it is not defined.

   	# get config
   	if (!defined $config_file ||
   	    $config_file ne "$git_dir/config") {
   		%config = git_parse_project_config('gitweb');
   		$config_file = "$git_dir/config";
   	}


The last solution, while requiring most work, has the advantage of being
able to do override via user (~apache/.gitconfig) or system (/etc/gitconfig)
gitweb config file.  But I am not sure if it is worth it...


As to why t9500 test didn't detect that: there is no test for project list
page when features are configured to be overridable...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
