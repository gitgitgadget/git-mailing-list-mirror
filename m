From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 15/16] index-helper: optionally automatically run
Date: Tue, 19 Apr 2016 18:31:19 -0400
Organization: Twitter
Message-ID: <1461105079.5540.131.camel@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
	 <1460507589-25525-16-git-send-email-dturner@twopensource.com>
	 <CACsJy8C8un8AAwr5OWX6b8+ync=hqe3JLb=zNMN947oDLmZo4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy =?UTF-8?Q?Nguy=E1=BB=85n?= <pclouds@gmail.co>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 00:31:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aseB9-00074b-Is
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 00:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbcDSWbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 18:31:23 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34681 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbcDSWbW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 18:31:22 -0400
Received: by mail-qg0-f54.google.com with SMTP id c6so18613178qga.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 15:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=/U6ROMOgOxWLlk6KJhk9dd7rOMcWaG8amGEKAbG9ez0=;
        b=EqWIspOLWkMqeoIFnvhqVrRw9yjqbJWXDaicAuC+OgsEk7g7brtlPG1eulsfKFpAgx
         47YbES0uqE0VR5tUHAaZLmeQAr5f9Fut9xiN22JTqc7PJqDscDURCYvAyasKtreuhNCD
         rKou3n+HahtxoTm6KxZ8xR6+g/dxc6G8NnnOGrMBM28wShb6EQCvVcCvqEX8aOTQ9eko
         QV/Es0O6kRQ9nHIeXBruSfcfLpyeYXpEoACQ+VAdxF7YsyAsKLe0ODxLW0Olyur7HndT
         7+shSqPkBy6RDZ4hcpdtzx8S+UWxveG9zaqI1j4h6bjdEWJxHKLrqBqAOxDv7XjJVQy6
         MTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=/U6ROMOgOxWLlk6KJhk9dd7rOMcWaG8amGEKAbG9ez0=;
        b=BBBMQ61+ERsbstviqUuezTmuDLaSAfxt6a0kjiXsNu5rXVJy7yskf2W3j7cuIfv6Ah
         k3my3oYxsZVPT/F+31LmC4lVfMGpO2emTCDFDqI4n6ZmYC7mydWJUrzh0Jxrycqw+m1O
         8JLJaudO9M9TdljQqi4aPj+7LKE0yy+dIOkGRL2s1ApwrFA7D8qK42O2/AUZjuwDLj/A
         ++Q3oVcOarC6n4vTwHqYxAICgDZT2tr/+io9Kb2mIZvG1pnkrGlQyDqdV8GdS249GK2P
         qFmlQRstYtGISjCFQwwAmjMaSFFSDckqSKAxVLEjnuTvY6cwDZTm13sQW048dm36JuRj
         usAA==
X-Gm-Message-State: AOPr4FW3dcnTOShHxFG/uLwJ4B1e3qzE2CEjAPdskO7deNddKw5YibQuVXri0viz/oDUFA==
X-Received: by 10.140.87.116 with SMTP id q107mr2973429qgd.61.1461105081110;
        Tue, 19 Apr 2016 15:31:21 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f13sm26524641qhe.7.2016.04.19.15.31.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 15:31:19 -0700 (PDT)
In-Reply-To: <CACsJy8C8un8AAwr5OWX6b8+ync=hqe3JLb=zNMN947oDLmZo4w@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291940>

On Sun, 2016-04-17 at 12:19 +0700, Duy Nguyen wrote:
> On Wed, Apr 13, 2016 at 7:33 AM, David Turner <
> dturner@twopensource.com> wrote:
> > @@ -536,8 +567,10 @@ static void handle_builtin(int argc, const
> > char **argv)
> >         }
> > 
> >         builtin = get_builtin(cmd);
> > -       if (builtin)
> > +       if (builtin) {
> > +               maybe_run_index_helper(builtin);
> >                 exit(run_builtin(builtin, argc, argv));
> > +       }
> >  }
> 
> Isn't it too early to start index-helper here? Unrelated commands
> like
> git-log are affected. And config handling this early could be tricky.
> A better place may be in the socket connection code. When we fail to
> connect, we can check config key and run index-helper then.

Will move.
