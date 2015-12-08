From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 13/16] init: allow alternate backends to be set for new
 repos
Date: Mon, 07 Dec 2015 19:38:52 -0500
Organization: Twitter
Message-ID: <1449535132.21906.0.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	 <1449102921-7707-14-git-send-email-dturner@twopensource.com>
	 <CACsJy8DDKW4np7N+KA=dpz9uNke0+cyQD-J3U74VM=4WbsjrKQ@mail.gmail.com>
	 <20151205074444.GD21639@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 01:42:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a66MK-0004Ge-Og
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 01:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967AbbLHAi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 19:38:58 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33974 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268AbbLHAiz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 19:38:55 -0500
Received: by igvg19 with SMTP id g19so91116986igv.1
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 16:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=ZKaUcQg76u5vBlaHBp+eMSHzwlwJ3nZXRxw33d4jEJc=;
        b=hqWc+KrbKBag+PbMQqDLDIpT+7mSH5c48/8k20HCK6Lo5cW1VceDXNBEA4yIQ9H4Uz
         5hob3H+WVEHONYnY+qTGgVhpwtMtIrkJ0g/aYIN5s/cZZTtsKeT/C6REEV68nyWLuxUE
         bjbuGvbgfeSpxL52dMNWld6qOxdeGEcsGKF9PF+gL8xeB85PlgS9pmvFoUh15Omz3itt
         er/LmOH0s2Kc5q/L6SPn3+6WCv5dQkExdiRE98czc1gNXAvyUsXOb0sb8XU6rMkijgjz
         O0J5Er83kucZI/ziz6FPw/ZoyBYPYJFDNA6iZn4ZAghdlaOQaw0BAy1E2l0YmX82mcSg
         zCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=ZKaUcQg76u5vBlaHBp+eMSHzwlwJ3nZXRxw33d4jEJc=;
        b=jHqdwVvx3AxlCmcK9/y+40dn3jIbWucSgMq238Nvl6Orafi/qBKeLyneYM/imjPwrO
         zM3Bh5YeJqp6Sxu0RrMaYBFUfjpX5krdN2kyJz+bPO5/Xwa1rO7VR2q5Wqj6zUtC1O3V
         +Gpbc7mtbYKtx3fDLJpn9sI+QKXsby5UD0DL/kE1DunKXYBFs9cSF9DxP8tqrZbaM10u
         rc02J++aEiN/V3sv5MCPN4394rleYsdY3COkeMHZMooqtHnmOcFTJ4My+NPCd5Hs2sGq
         ljl3SY82kcgyFUq/B06RPw1CIBwPGJ7O2YlYA6F9qsdH1TnuhMXKQ49Ama1RMZbD5Dzu
         nc5Q==
X-Gm-Message-State: ALoCoQm7qu3aORLLRyk0o4oBeSRMnGg9oxprgZSmHiTDdIKEirqLMXYns2KFa+4Aj6e2Y81eR6bLLJ5jz0jJ1DOvozFwP+NaFQ==
X-Received: by 10.50.62.104 with SMTP id x8mr1240009igr.22.1449535135190;
        Mon, 07 Dec 2015 16:38:55 -0800 (PST)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id uf7sm503740igb.11.2015.12.07.16.38.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Dec 2015 16:38:54 -0800 (PST)
In-Reply-To: <20151205074444.GD21639@sigill.intra.peff.net>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282143>

On Sat, 2015-12-05 at 02:44 -0500, Jeff King wrote:
> On Sat, Dec 05, 2015 at 07:30:13AM +0100, Duy Nguyen wrote:
> 
> > On Thu, Dec 3, 2015 at 1:35 AM, David Turner <dturner@twopensource.com> wrote:
> > > git init learns a new argument --refs-backend-type.  Presently, only
> > > "files" is supported, but later we will add other backends.
> > >
> > > When this argument is used, the repository's core.refsBackendType
> > > configuration value is set, and the refs backend's initdb function is
> > > used to set up the ref database.
> > 
> > git-init can also be used on existing repos. What happens in that case
> > if we use --refs-backend-type. Will existing  refs be migrated to the
> > new backend or hidden away?

I'd like to migrate, but I don't want to write that code prematurely.  I
figure we can get everything else right first.  

> It would be neat if it migrated, but I suspect that may introduce
> complications. It's probably OK in the initial implementation to bail if
> the option is used in an existing repo.

Will fix.

> I think the config option needs to be extensions.refsBackendType, too,
> per the logic in 00a09d5 (introduce "extensions" form of
> core.repositoryformatversion, 2015-06-23). And I guess it needs to bump
> core.repositoryformatversion to "1".

I did that in a later patch, but now is a better time; will fix.
