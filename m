From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 0/2] MSVC generator fixups
Date: Mon, 28 Sep 2009 15:01:30 +0200
Message-ID: <bdca99240909280601r296d66efi78a6092282ffc256@mail.gmail.com>
References: <4ABB84F4.7080403@gmail.com> <cover.1254137149.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, spearce@spearce.org, msysgit@googlegroups.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 28 15:02:05 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f141.google.com ([209.85.221.141])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsFrW-0007mo-RH
	for gcvm-msysgit@m.gmane.org; Mon, 28 Sep 2009 15:01:54 +0200
Received: by mail-qy0-f141.google.com with SMTP id 5so3889258qyk.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 28 Sep 2009 06:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=B0ZcHtL0eGyZ4+I4ksHmdsIGd6B4mONbfbIWl7aElqY=;
        b=ngjN2Um8pTFVIjHcluBv3EGY0yi4Arcodp8Nhg10zZnfEkWj99LVBzLoXCLimab6CR
         gwxcRmx0E+o62YsuzDLM/3zw/6wegzDKGvElCNg9kFSDJGQNlU9hyre2Szdd49HYxbE8
         GfwzS8aUtgVBI5zkehqzya99+63ynfM7N6Fbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=jMOulBaFh/fmfl474lRNpQBEiuY5T7IYnb8Z5zdXHSUpCWK0NxbzjQF5xcI2iczQ79
         Ka7roeUxnd64EHawM8uiiBf2BaHdCzrNCPJWn8gGyOYlYVeiA8wGCYKQEZ8Kk3fsEPa1
         +/NRBx0YUTMS7mTHMXqf4UpQAJChW8/FcC4gE=
Received: by 10.229.114.218 with SMTP id f26mr217481qcq.17.1254142908476;
        Mon, 28 Sep 2009 06:01:48 -0700 (PDT)
Received: by 10.177.125.36 with SMTP id c36gr7170yqn.0;
	Mon, 28 Sep 2009 06:01:35 -0700 (PDT)
X-Sender: sschuberth@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.86.192.36 with SMTP id p36mr79692fgf.20.1254142893429; Mon, 28 Sep 2009 06:01:33 -0700 (PDT)
Received: by 10.86.192.36 with SMTP id p36mr79690fgf.20.1254142892022; Mon, 28 Sep 2009 06:01:32 -0700 (PDT)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157]) by gmr-mx.google.com with ESMTP id e3si402587fga.16.2009.09.28.06.01.30; Mon, 28 Sep 2009 06:01:31 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 72.14.220.157 as permitted sender) client-ip=72.14.220.157;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of sschuberth@gmail.com designates 72.14.220.157 as permitted sender) smtp.mail=sschuberth@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by fg-out-1718.google.com with SMTP id d23so1322218fga.11 for <msysgit@googlegroups.com>; Mon, 28 Sep 2009 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type; bh=R7wvP+IHkI/LuHUrUOrm8i2xl/KlPR9HW+INB5JX15c=; b=lvTW0cWfK4/3YhJUYzWV3LKxZuNs37k+Bf3POSRrYv0IlL04W3+eWf06li8yE3xDZE tuHWqItqDjHYS/xEzKkX4fMAF0qA8LAZZ8sElKFYnOGFqYz/Z3UuPP+HQhti0XNZzJuC HqSlNuSPMgf5QftB1B9fSG544v0cNnAMZPN/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type; b=gdCROFbR8FgmgnmGIxXs3rBtrdmMDNXb8UHG+t5VdyrzXkX771GNHpJ8SXSYxu9qpc M6m6x6JWdDD+sT0D7hz4L+2bQC2aeOAc0zNlUfbVRGHe0fb5xFOL68b+Hz0AqlSNuQ79 fMHlXCiFF65HUrIHMqac2fT3j2QBv5k7/lTMs=
Received: by 10.86.173.4 with SMTP id v4mr3266271fge.78.1254142890836; Mon, 28  Sep 2009 06:01:30 -0700 (PDT)
In-Reply-To: <cover.1254137149.git.mstormo@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129259>


> The two patches didn't apply for me in the way they were sent. I
> manually applied them ontop of master, and added an Acked-by.

Thanks for fixing my patches, Marius!

-- 
Sebastian Schuberth
