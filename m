Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589B15B5
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 13:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=piedallu.me header.i=@piedallu.me header.b="k67j+WeY"
X-Greylist: delayed 2433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Nov 2023 05:31:09 PST
Received: from 10.mo580.mail-out.ovh.net (10.mo580.mail-out.ovh.net [46.105.63.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DE2824E
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 05:31:09 -0800 (PST)
Received: from mxplan8.mail.ovh.net (unknown [10.108.4.98])
	by mo580.mail-out.ovh.net (Postfix) with ESMTPS id 7697722AF2
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 12:10:43 +0000 (UTC)
Received: from piedallu.me (37.59.142.102) by mxplan8.mail.ovh.net
 (172.16.2.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 12 Nov
 2023 13:10:43 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-102R0049c4afe39-05a7-4eed-921c-04c887fed48e,
                    594C10B4051E75A9ADB4331887D623E2EF0A6297) smtp.auth=postmaster@piedallu.me
X-OVh-ClientIp: 176.169.226.152
Message-ID: <cb89d863-12d4-412b-a25b-9eedce996708@piedallu.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=piedallu.me;
	s=mailkey; t=1699791042;
	bh=dDzK8B0EewTkMwRuyNcKknWGZwy0NLvv0Y+i4SIYaFw=;
	h=Date:To:From:Subject;
	b=k67j+WeYtu1lFEn6QwhEO3j3MPf5bT+EUS7uPu64uVJH7gYFSliUqz9xCdZ6TmUnb
	 b7BpJdubm4JDdIgsPqYzDJNm75xxEhKBfhL+gehepElCUxs1kgxkJwWjHe7qRj6Bz2
	 49HnyZYnc0u6vAs8WV+1Gj+yk5LRQrBDGEtmqYiI=
Date: Sun, 12 Nov 2023 13:10:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Content-Language: en-US
From: =?UTF-8?Q?F=C3=A9lix_Pi=C3=A9dallu?= <felix@piedallu.me>
Subject: Declutter the home directory
Autocrypt: addr=felix@piedallu.me; keydata=
 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
 YdyFHmnvABzje+qUTqmK219FxF6yPw==
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-GUID: 084d7f79-1694-4b52-80c3-e273e74404b5
X-Ovh-Tracer-Id: 13889945679487535127
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddvkedgfeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefkffggvffhufgtgfesthekredttddtjeenucfhrhhomhephforlhhigicurfhirogurghllhhuuceofhgvlhhigiesphhivggurghllhhurdhmvgeqnecuggftrfgrthhtvghrnhepjeeghedttdejteevtdekueetuedvgeeikeevvdfgvddvveeuieelieejieekhfeunecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecukfhppedtrddtrddtrddtpddujeeirdduieelrddvvdeirdduhedvpdefjedrheelrddugedvrddutddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhekrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepfhgvlhhigiesphhivggurghllhhurdhmvgdpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedt

Hi,
I'm new on this mailing list so please tell me if the subject was 
already discussed.

The Freedesktop XDG Base Directory specification 
(https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) 
aims to declutter the home directory by moving files where they should 
be more logically located. Here i'll be talking about some directories:

* $XDG_CACHE_HOME, that defaults to the well-known $HOME/.cache
* $XDG_CONFIG_HOME, that defaults to the also well known $HOME/.config
* $XDG_RUNTIME_DIR, that should contain non-essential runtime files
   such as socket files

For now 4 kind of files are put in the $HOME directory by git:

* .gitconfig | .config/git/config
   it defaults to .gitconfig

* .git-credentials | .config/git/credentials from the credential-store
   it also defaults to .git-credentials

* .cache/git/credentials | .git-credential-cache/ from credential-cache
   this one defaults to .cache/git/credentials/

* .git-fsmonitor-%s for Darwin file system monitor.


I have 3 propositions:

## Move runtimes files to $XDG_RUNTIME_DIR

* .cache/git/credential/ -> $XDG_RUNTIME_DIR/git/credential/
* .git-fsmonitor-%s -> $XDG_RUNTIME_DIR/git/fsmonitor/%s

Those file shall be deleted at the end of the user session, so this is
the good place to store them.


## Move ~/.config/git/credentials to ~/.cache/git/credentials

Indeed this might contain sensitive information that some users don't 
want to be backed up or synchronized.
A possibility would be to read ~/.cache/git/credentials, 
~/.config/git/credentials, ~/.git-credentials, and to use the first 
existing one.


## Default to XDG paths instead of home directory

It would just swap the priority of the two possible paths. It would also 
only impact new installations as, if ~/.gitconfig exists, it would keep 
being used.



The goal of those propositions is to declutter the home directory, and
ease the cleanup, backup and synchronisation of user settings.


Thanks for reading me.

Félix Piédallu
