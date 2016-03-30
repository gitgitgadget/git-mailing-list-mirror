From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/2 V3] MSVC: Use shipped headers instead of fallback
 definitions
Date: Wed, 30 Mar 2016 13:40:43 +0200
Message-ID: <56FBBB3B.8000004@gmail.com>
References: <56FAACD4.9080504@cs-ware.de> <56FAB9FD.7080409@cs-ware.de>
 <56FB93B9.7090306@gmail.com> <56FBBA80.8090908@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Sven Strickroth <sven@cs-ware.de>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, blees@dcon.de
X-From: git-owner@vger.kernel.org Wed Mar 30 13:41:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alEUa-00033N-Tl
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 13:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbcC3Lks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 07:40:48 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33898 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbcC3Lkr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 07:40:47 -0400
Received: by mail-lf0-f68.google.com with SMTP id f127so4680330lff.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 04:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=b8jcwUDWa7hGtjdIiw3tVLPHmm6SQQFqaas7iz1WXLM=;
        b=nm3e8xQ0+qv3o2Zy83DbsTJ3KTRuos8/yOW+HZ1d4ehDlL2IAGTo+FPriuKKPaGWal
         nknUXxVriHBd4Wa69LSNaux/zFNInis/OVtfHkJFcboQzQcX0zQNpfQ8Js0uZBeDK6Hq
         gBoMr2tgMAyTFBGTKnx6J7QDjdWXj5v44ZnR+XIkiLsfq3gJ3lZoH7iVpcC6PQzBP6RU
         7QOF5NUO6q32ejtvEQ9DAnmdONZWFJXNaBeO66hFOjpDKEdJckh95z8Gzh751xvleV8g
         LgHH9UxQXcbZtBGQf7f4eq92GqBbPgF29wS6Fg2VrC+x43D896vOq5m4h+2VtN9mNKMC
         n19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=b8jcwUDWa7hGtjdIiw3tVLPHmm6SQQFqaas7iz1WXLM=;
        b=YF3uADK2XugHsJaYvufTJTSCdagYqoWAPpPTDWklnjp6KW5DCdZW8Pvd9pO98vX3fw
         A2kbv94PbucMfct/glxDX962dG9EnJVmWUBxXzDPgBfNcU2r5iZfsrWtUpFFm6M7i1Vt
         D6YgdbSoxjCt8IjOXqoZxIhGZFMWvTjHO7zZt9totg/cnGZ5A57ZYIX9DD8mnE5Sfe5c
         MMoljvVEKOJO0peybNBT+KvWcHCLmPDN/aElAi2H9kwkZN18ayLEuXZk3MCXVfblK6kR
         IE2XKV7RFWcgaQz8Af9e8U7Z+VwkFIR4CfDxWWLVhw8LIi83e5WOuJNv+axi3f+NmycJ
         M4BA==
X-Gm-Message-State: AD7BkJKSUfSD3RLHeWKs0fET3P+iC6ikWCkgGQvae+rSfMcz6t4aPJZybgXPjZhGxyrtFQ==
X-Received: by 10.195.17.200 with SMTP id gg8mr8904778wjd.72.1459338045301;
        Wed, 30 Mar 2016 04:40:45 -0700 (PDT)
Received: from [10.223.62.205] ([131.228.216.133])
        by smtp.googlemail.com with ESMTPSA id t8sm3504019wjy.41.2016.03.30.04.40.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2016 04:40:44 -0700 (PDT)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <56FBBA80.8090908@cs-ware.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290301>

On 3/30/2016 13:37, Sven Strickroth wrote:

> VS2010 comes with stdint.h [1]
> VS2013 comes with inttypes.h [2]
>
> [1] https://stackoverflow.com/a/2628014/3906760
> [2] https://blogs.msdn.microsoft.com/vcblog/2013/07/19/c99-library-support-in-visual-studio-2013/
>
> Signed-off-by: Sven Strickroth <sven@cs-ware.de>

ACK.

Regards,
Sebastian
