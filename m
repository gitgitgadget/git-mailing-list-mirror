Received: from out.smtp-auth.no-ip.com (smtp-auth.no-ip.com [8.23.224.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0274166316
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=8.23.224.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339485; cv=none; b=mJc2JEQe9UMZMs8pt8GbltBl/CmJ0ht1eA2vkT8M14w9rjgGcue1+yfEnqkKHR2LcPt/qTErE9njqjYJhnSdIOi0aqesgh9pjOt9SXOwUBy+qIl68ucAW3joYjLMyUowhsihb0DYMB/FSsDW8ZlLCYPMlcxkdYYWYu46boECXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339485; c=relaxed/simple;
	bh=0sdxOh9gDyDKqnZWrGxqfwttPpDW8fzXQrlkxgSePiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e63UZbbqb4BbtBQVYPY6lb0MZEkVxtQd++ewY7T4t+GP9DUfmD9eAXBDZqYKeYwiRaqa1goHA/OHkq1/dZBUYHGce3jJZDxeI1gXipscp5fJsBocs3DwjJDWWL5aXASIpBm6yGtGsOvdq8MWG2roRtf5bF/rfxgb/+XoLWF0bzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flyn.org; spf=pass smtp.mailfrom=flyn.org; dkim=pass (3072-bit key) header.d=flyn.org header.i=@flyn.org header.b=moKgE8A2; dkim=pass (3072-bit key) header.d=flyn.org header.i=@flyn.org header.b=moKgE8A2; arc=none smtp.client-ip=8.23.224.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flyn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=flyn.org header.i=@flyn.org header.b="moKgE8A2";
	dkim=pass (3072-bit key) header.d=flyn.org header.i=@flyn.org header.b="moKgE8A2"
X-No-IP: flyn.org@noip-smtp
X-Report-Spam-To: abuse@no-ip.com
Received: from www.flyn.org (unknown [137.26.240.243])
	(Authenticated sender: flyn.org@noip-smtp)
	by smtp-auth.no-ip.com (Postfix) with ESMTPA id 4WYCrx1xpbz7sCR
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 11:37:53 +0000 (UTC)
Received: by www.flyn.org (Postfix, from userid 1001)
	id A056C1EE002F; Tue, 30 Jul 2024 06:37:51 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyn.org; s=mail;
	t=1722339471; bh=VqpsBh690WYfO0WEX69ZVAu2gDnHlYvUqi5WKZhyIcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=moKgE8A2BsQSgJubcADBfvhy/IDMGkxOM6VAqFNc64mVq2txA0jSktwB+ImHL0eVd
	 WZIJEB4rlRElz1/NXQkYzkqg4SmsBmhQMh/t24vVyVR7RGFnlUh97Cox1xJUyfD55w
	 OFoBITydrg3vfze8vYznzqZLDmSXB9AQ9fh+iy/nJfupsU6EvOsEKxE/EN9uQ5w47f
	 5A/nwLFrTaQakjxbNGgqIleDlVQE2MO5b7fdYKvRfhVaF3NT46QvVhaM2slVTepYFd
	 mF2AKcCQOZsA+EPMIGStqEBx1oJQNXUhV+Ms7TNX0p16MBxj6OssXVhAdz6oYUreoB
	 QsLavGXZjn/cmLKLcS/hZrgWDPbeTKBu3eE+XB9d/vWX9LjGM9EtFJ6Ww+IOCVGaES
	 IldorqlvVbFcaGLrV7puxLo0tJYSWXqfSYD31OMxaMndObjuSJFD6NfV6Icj3sVy4y
	 H1nTH0RaXFYkUbu0q1fbcD7rGKsCfL0Mug8vrvKexad9//eZ3Tc
Received: from imp.flyn.org (syn-068-114-216-194.res.spectrum.com [68.114.216.194])
	by www.flyn.org (Postfix) with ESMTPSA id 5EE1F1EE0029;
	Tue, 30 Jul 2024 06:37:51 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyn.org; s=mail;
	t=1722339471; bh=VqpsBh690WYfO0WEX69ZVAu2gDnHlYvUqi5WKZhyIcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=moKgE8A2BsQSgJubcADBfvhy/IDMGkxOM6VAqFNc64mVq2txA0jSktwB+ImHL0eVd
	 WZIJEB4rlRElz1/NXQkYzkqg4SmsBmhQMh/t24vVyVR7RGFnlUh97Cox1xJUyfD55w
	 OFoBITydrg3vfze8vYznzqZLDmSXB9AQ9fh+iy/nJfupsU6EvOsEKxE/EN9uQ5w47f
	 5A/nwLFrTaQakjxbNGgqIleDlVQE2MO5b7fdYKvRfhVaF3NT46QvVhaM2slVTepYFd
	 mF2AKcCQOZsA+EPMIGStqEBx1oJQNXUhV+Ms7TNX0p16MBxj6OssXVhAdz6oYUreoB
	 QsLavGXZjn/cmLKLcS/hZrgWDPbeTKBu3eE+XB9d/vWX9LjGM9EtFJ6Ww+IOCVGaES
	 IldorqlvVbFcaGLrV7puxLo0tJYSWXqfSYD31OMxaMndObjuSJFD6NfV6Icj3sVy4y
	 H1nTH0RaXFYkUbu0q1fbcD7rGKsCfL0Mug8vrvKexad9//eZ3Tc
Received: by imp.flyn.org (Postfix, from userid 1101)
	id E08202D8D8EA; Tue, 30 Jul 2024 06:37:47 -0500 (CDT)
Date: Tue, 30 Jul 2024 06:37:47 -0500
From: "W. Michael Petullo" <mike@flyn.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: Git clone reads safe.directory differently?
Message-ID: <ZqjQi6i2kiY4gcc1@imp.flyn.org>
References: <ZqUc8DJ1uKcHYlcy@imp.flyn.org>
 <20240727215845.GA1263246@coredump.intra.peff.net>
 <ZqZjRMqpEV_3WIkD@imp.flyn.org>
 <20240728224807.GA1299337@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728224807.GA1299337@coredump.intra.peff.net>
X-Bogosity: Unsure, tests=bogofilter, spamicity=0.520000, version=1.2.5

>> I was able to overcome this by creating /home/alice/git-shell-commands/upload-pack-safe,
>> placing the following there
>> 
>> 	#!/bin/sh
>> 
>> 	git -c safe.directory="$1" upload-pack $1
>> 
>> and running:
>> 
>> 	git -c safe.directory="*" clone -u upload-pack-safe alice@git.example.com:/shared/repository
>> 
>> This seems to be another interface edge case. Is my solution reasonable,
>> or is there something else that would be more consistent?
 
> So yeah, that would work. But it might be simpler still to just put
> "[safe]directory = *" into /home/alice/.gitconfig. Then the client side
> does not have to do anything differently (or you could even put in a
> more limited relaxation of the rules, like "/shared/repository/*" or
> whatever).

A little feedback to regarding why I chose to avoid .gitconfig along
with some consequences:

I have a system built around Git in which I use the permissions approaches
I have described in this email thread. The downside of .gitconfig is
that its effect is global. I fear I might lose track of the fact that I
have turned off a security protection in a global way, possibly years
down the road as I maintain my system.  Instead, I went about this by
patching particular uses of Git to use "-c" and so on. I only needed to
do this at two or three places my code executes Git out of dozens.

This makes my intention clear in the code (that executes Git) and lessens
the likelihood of me (a year or so later?) forgetting I am responsible
for ensuring the circumstances leave my use of safe.directory safe.

I suppose the inconsistency surrounding "-c" that we have discussed sort
of works against my approach. Indeed, I wonder if in an ideal world we
should remove the dangerous features that have good intentions
(hardlinks and so on) and instead require users to opt in to them.
I say ideal world because this ignores backward/forward compatibility
issues.

Perhaps a compromise would be to tie safe.directory to the type
of source directory given to clone. Would a remote URL be enough to
turn off the safe.directory checks on a clone, similar to the effect of
a remote URL on --local/--no-local?

The current behavior seems to mean:

	(1) -c safe.directory works for some sub-commands, but not clone,

	(2) clone requires your additional workaround, and 

	(3) your workaround does not work with SSH/git-shell for the
	obvious reason that git-shell needs to limit the "commands" it
	will run; this requires another level of intervention.

Another thing I came across was in the git-clone man page:

	"When given, and the repository to clone from is accessed via ssh,
	this specifies a non-default path for the command run on the other end."

Your "-u 'git -c safe.directory=X upload-pack'" workaround uses
upload-pack in the absence of SSH, so I wonder if "and the repository
to clone from is accessed via ssh" is inaccurate.

-- 
Mike

:wq
