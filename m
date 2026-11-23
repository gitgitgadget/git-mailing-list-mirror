Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467619;
	b=kVh8RQKc87pN5y69QDDX1C6BGObsaElrfQkgWyNhfFzS4A4EEwD0+s3k5qUplZaaM0ar
	 C7XzQeFPHUIKprJpkcVd11R4d9QDD0aUOwGR2qqedmB+8jj5zqneyAY1LM/+vBM6Icsz8
	 uiBAWBqC19gyr+/mgfluh/blLz9KBMpEET5VTQhv1+vXvSK+keTqJgGdqdQQ6RyNa29t9
	 2s3Jw2nS5SFfI344Wl4GD6AUjKf3HjiMjvPpZpx2FboLWa55SKA8R+qOQ7KgDhD2ksEtQ
	 f0ZETU8imJhbj/ddXLeFrbC60BIoaNlrE1s/gPx+PV+CtXTvaGtelPf+I07ZH+kPkXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467619;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Spam-Status:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=2tHliz5Rig7qfi3Mz3w1K+MI+niTRniRVsvK1o2Pd3c=;
	b=Puli6zmuzJGHGWN1857t6G9iB8rdLd5/pKv2KS0iz6+hspXebClb2DXQ0bt7l1h+s7eW
	 eqFyYMpjJ2im1EwnOdiANP070dgGHUK9d+k2SOwhqt2o1uqk8DSN+QKzJIQlWFCkifS27
	 BX2BCNHp2AaIK5xyUUe0jeSO7mA2Fm3/wW9/WkYo1OZ6yXqVWa9CRbJ4EkqlgYAxx6HZT
	 RWaWWLBtvuQoUm8CBStFI8vr/oG5dMy9pYOZc33Fs78IpqMBCC+KGnxsvuN9cp+xZIqBJ
	 skG8V7WPn+JcgF2HtWvKCxc1mOOW0l4m5WIBm2J/15211BCtxe5i3ZwVGrTLR6cjZ/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=JZx7kkwv;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF231606A326
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 21:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF231606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=JZx7kkwv
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 7CB86A0A2D;
	Mon, 23 Nov 2026 21:00:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id B39432000E;
	Mon, 23 Nov 2026 21:00:10 +0000 (UTC)
Date: Mon, 23 Nov 2026 16:00:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: Prevent git reset --hard from losing data
Message-ID: <20261123160009.61bf0bce@gandalf.local.home>
In-Reply-To: <awC0MJDYS88yEtgm@exploit>
References: <20261120145444.13061eb7@gandalf.local.home>
	<awC0MJDYS88yEtgm@exploit>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 41bwoppnr34axabzxnkshztm8u8zainb
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B39432000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19DmwE2ptjZuxR7ygOnxx/Z1SLikXpRE0o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=2tHliz5Rig7qfi3Mz3w1K+MI+niTRniRVsvK1o2Pd3c=; b=JZx7kkwvOU45bJ6VZ3hD6s3QJspfWa2/MBtkAt6vFVttM3uahHEf9EPS69vcuaZFsuRyRisnYbxa8WSB7hGauEM1xY4RrjjFVFFeb1Rdv+8BcFUTmgYsXh6TLkw23UXj/xwelOM5nzn8liwEwPtbilt1gOZx7sATNaX1MKKiISE=
X-HE-Tag: 1795467610-89398
X-HE-Meta: U2FsdGVkX19D0jqAzw9atYvo14owqqI+MKqYjXYbU7nvzReRDwSfIx3nhjqVmEXIGcsY+WkTP9YPggYwSD4P2y4vaHu0VgC9vL6M3Rc1uAXRlcOR7KHAJ9gpvCOOxdIugrA/JHAazUSVLesMfaEjrvAC2cDgzaeR3HnKni8vQ3cuYpCS5UWgH4jYvP5JtsekdtaRXY6yt0XFOQEJwNSDGcQvwtx7pADKpEka/vC8wDeCNkLj9FED+uB8QlBzIaQRik6b/kMq/yWQ/ViqQ/ssos2Rm2g0GbGiWI3rD9mZIgE/v01+TCwQQ2vOZcB0TzWJ

On Fri, 20 Nov 2026 22:09:32 +0100
Mirko Faina <mroik@delayed.space> wrote:

> You could just reset without the --hard option and restore what you
> don't want to keep. Otherwise there's the --keep option that aborts the
> reset if there's local changes, but you'd have to remember to type it
> out every time.

I just tried it without the --hard and it reminded me why I never use that.

I just wanted to update one of my branches to one of my devel branches and
did a git reset without the hard and at the end it gives me:

 $ git diff | diffstat
 .clippy.toml                                                                                                   |   21 
 .editorconfig                                                                                                  |   27 
 .pylintrc                                                                                                      |    2 
 /dev/null                                                                                                      |binary
 AGENTS.md                                                                                                      |    1 
 Documentation/.renames.txt                                                                                     | 1185 
 Documentation/ABI/obsolete/automount-tracefs-debugfs                                                           |   20 
 Documentation/ABI/obsolete/sysfs-driver-ivpu                                                                   |   30 
 Documentation/ABI/obsolete/sysfs-driver-samsung-laptop                                                         |   10 
 Documentation/ABI/obsolete/sysfs-kernel-kexec-kdump                                                            |   71 
 Documentation/ABI/obsolete/sysfs-platform-ideapad-laptop                                                       |    8 
 Documentation/ABI/removed/sysfs-class-cxl                                                                      |  272 
 Documentation/ABI/removed/sysfs-driver-uniwill-laptop                                                          |   10 
 Documentation/ABI/removed/sysfs-firmware-efi-vars                                                              |   12 
 Documentation/ABI/removed/sysfs-selinux-user                                                                   |   12 
 Documentation/ABI/stable/configfs-nvmet                                                                        |  352 
 Documentation/ABI/stable/sysfs-class-bluetooth                                                                 |    9 
[...]
 tools/virtio/linux/mod_devicetable.h                                                                           |   14 
 tools/virtio/linux/ucopysize.h                                                                                 |   21 
 tools/virtio/linux/virtio_features.h                                                                           |   79 
 tools/virtio/oot-stubs.h                                                                                       |   10 
 tools/virtio/ringtest/.gitignore                                                                               |    7 
 tools/virtio/vhost_net_test.c                                                                                  |  527 
 tools/workqueue/wq_dump.py                                                                                     |  255 
 tools/workqueue/wq_monitor.py                                                                                  |  168 
 tools/writeback/wb_monitor.py                                                                                  |  172 
 usr/dummy-include/limits.h                                                                                     |    8 
 usr/dummy-include/stddef.h                                                                                     |   13 
 usr/dummy-include/stdint.h                                                                                     |   17 
 usr/dummy-include/string.h                                                                                     |   12 
 usr/dummy-include/sys/socket.h                                                                                 |   12 
 usr/dummy-include/sys/time.h                                                                                   |    3 
 virt/kvm/guest_memfd.c                                                                                         | 1446 
 virt/kvm/guest_memfd.h                                                                                         |   43 
 72642 files changed, 2141941 insertions(+), 13317958 deletions(-)

This is why I always use --hard with git reset.

I'll use a script to get what I want.

Thanks,

-- Steve
