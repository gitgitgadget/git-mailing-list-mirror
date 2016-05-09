From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v9 00/19] index-helper/watchman
Date: Mon, 09 May 2016 18:15:34 -0400
Organization: Twitter
Message-ID: <1462832134.24478.49.camel@twopensource.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
	 <xmqqa8jyuczj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 00:15:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aztSn-0007Wu-Pt
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 00:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbcEIWPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 18:15:38 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35248 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbcEIWPh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 18:15:37 -0400
Received: by mail-qg0-f45.google.com with SMTP id f74so96917395qge.2
        for <git@vger.kernel.org>; Mon, 09 May 2016 15:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=6ON674NE0ALxwIyGkH6eyw44NGkWKltZGg7B5OI+4Gs=;
        b=br+wzszKkq/Mvj6w5sGhreGGw8rg9tbjb+ffKkV0L1///zhsj4Mn6zNDVJHMQeyCUb
         82Ik6dI6h+vZNa7rmfIBSc7QH8IOmP27KOZJSapI625jFZEmTjlt2EScSvzc+aGi+288
         xPGD3Iym1Mjbr83MJcI/EXpZRF5wpH19Ev2+HVCFwmpIYV5sVNJv8t8fQMR6VJxbp/b9
         lizByCFO2/13cLUEXQByAgipckdLgSlPdvhVL28P0EqNqbB7KOW/a9i325j0EX0NGDSX
         ugHkfrRBd3xAsDFXogn6A7RTsTd0oJ8aKubVUH2l2BUMl5OC6A+XUi3PVoDrEGZrdxh0
         Gb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=6ON674NE0ALxwIyGkH6eyw44NGkWKltZGg7B5OI+4Gs=;
        b=T6S/8sUYZ8DZhAjpLw4Tc+Ch+CnIIqiGLGL+SGi8hNEJsNkW8JvAznD2rUxZvLg8o8
         CtdaApSll/By6m1s5B3du1tbXLFUHiNelOOqIGLbxa1/yNzzzAHO6YspYX9e+VePXeW6
         MH5SuQtKr3QKn16ynreY8JeUmcqkVjxGCw57QeAGpnpVMb5Lt6f36yVl8gGLHmKy/+rW
         S7fBap4ZQyazt0o041jNTLwWRmuLDvo7Td8GZyF4Pj7xidBAXI+2BfcKEw7s2uOkvLM6
         mWhTMBNXiVgxIlAC3KQUVagU2k1WvezNaAhKPpLiDsK1CMPVc7peWLAGI9D/hwkrxnE6
         4o+A==
X-Gm-Message-State: AOPr4FXZ0xa5bVIzPtM9Ez+SBFn56Ub7ORxSbEpWHN28PFO2npkzUANUJ1XTDdD0KvDXjw==
X-Received: by 10.140.93.103 with SMTP id c94mr37409058qge.74.1462832136388;
        Mon, 09 May 2016 15:15:36 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f6sm12714079qgf.4.2016.05.09.15.15.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 15:15:35 -0700 (PDT)
In-Reply-To: <xmqqa8jyuczj.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294078>

On Mon, 2016-05-09 at 14:40 -0700, Junio C Hamano wrote:
> Hmmm, I seem to be getting
> 
>     $ cat t/trash*7900*/err
>     fatal: Already running
> 
> after running t7900 and it fails at #5, after applying
> "index-helper: optionally automatically run"

It still passes for me (with or without USE_WATCHMAN set).  I'm testing
on Ubuntu 15.10 with "Linux ubuntu 4.2.0-35-generic", on an ext4
filesystem.

Does it fail before or after git status 2>err ?  (If before, then those
"err" contents are from the previous test).

Is index-helper in fact running after the test fails? 

Can you tell me a little about your system?  I'm not even sure what
would be useful here, but if I could set up a similarly-configured vm,
I could try to repro.

Thanks, and sorry for the failures.
