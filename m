From: demerphq <demerphq@gmail.com>
Subject: Re: why still no empty directory support in git
Date: Tue, 30 Dec 2008 09:43:07 +0100
Message-ID: <9b18b3110812300043l55a42f6sd995f36bf857543e@mail.gmail.com>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com>
	 <alpine.DEB.2.00.0812300008060.31590@vellum.laroia.net>
	 <alpine.DEB.2.00.0812300113050.22107@vellum.laroia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Asheesh Laroia" <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 09:44:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHaDF-0001ZF-43
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 09:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbYL3InM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 03:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbYL3InK
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 03:43:10 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:4120 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbYL3InJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 03:43:09 -0500
Received: by qw-out-2122.google.com with SMTP id 3so4056136qwe.37
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 00:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Y8BxjW2zbHbvSLmuv2acvx1yIBpU9mLGjNI7I/qFbBY=;
        b=J3Qyg4oikwDfLLCiK2vD4Zvcyt9f4Y8XSSHKDTi0/72yhWgoi6+hnLqmwyuhC5/vqN
         Wz000j6WXKDKoGTsG3IWNUa5iY/sj7z9GYXNZOCYfB3X/HujL8vTF13W8GR2cyvZPoqr
         x9u6GzMCEenWpW/QBe+eQZ6mvv/0sODzDhANQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AUP3i0YlWxKuQH1JXbT2zWlhcZSpTtTxEf4PCcRtullfVmicmnJ8NMB69z3oRU9D/d
         3qGdUSVgDQKe3xzRi3Ir94sec8kJAWylcIS0NEE53GLkeEEwiW8DVsDxGsKrrnpimWNN
         YJ2XkpHXchQ5lfR1JKjRiaa407Sq6iKHzc6Jw=
Received: by 10.214.80.14 with SMTP id d14mr12094923qab.62.1230626587668;
        Tue, 30 Dec 2008 00:43:07 -0800 (PST)
Received: by 10.214.217.13 with HTTP; Tue, 30 Dec 2008 00:43:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0812300113050.22107@vellum.laroia.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104169>

2008/12/30 Asheesh Laroia <asheesh@asheesh.org>:
> On Tue, 30 Dec 2008, Asheesh Laroia wrote:
>
>> On Tue, 30 Dec 2008, Ping Yin wrote:
>>
>>> 2. unclear logic, for example, whether to remove the directory after the
>>> last file in it is deleted
>>
>> This is the thing I dislike most about git: that it sometimes calls
>> rmdir() for me.  At least, one should be able to turn it off in a
>> per-repository basis.  I'm going to see how hard a patch that would be to
>> write.
>
> Well, changing this behavior seems to be "as easy as" changing unlink_entry
> in unpack_trees.c to not always rmdir(). The most naive thing I can think of
> is to have unlink_entry in unpack_trees check against the git config. It's
> probably more sensible for unpack_trees to be passed an argument that
> determines if it rmdir()s; that argument could be set via argv at "git
> unpack-tree" time, which could be set out of a configuration value read at
> "git" time.
>
> Would a change of the "more sensible" kind possibly be accepted by the git
> maintainer?
>
> I ask about this because I'm using git to track email in Maildir
> repositories, and in that vein I'm getting bitten by git's removal of empty
> directories.

Add a .exists to each directory.  There is precedent for such an
approach in other systems.

cheers,
Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
