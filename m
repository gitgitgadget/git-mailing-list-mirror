From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] Handle atexit list internaly fo unthreaded builds
Date: Mon, 13 Oct 2014 07:56:05 +0700
Message-ID: <CACsJy8CbhS=dv3fHvyTv0b-jazh3XS+nswmz_0AsLeHqko794g@mail.gmail.com>
References: <1413039218-12139-1-git-send-email-etienne.buira@gmail.com> <1413104974-3861-1-git-send-email-etienne.buira@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Etienne Buira <etienne.buira@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 02:56:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdTwG-0005Ct-0g
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 02:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbaJMA4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2014 20:56:36 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:63285 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbaJMA4g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2014 20:56:36 -0400
Received: by mail-ig0-f178.google.com with SMTP id h3so8778233igd.11
        for <git@vger.kernel.org>; Sun, 12 Oct 2014 17:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3+7xR+H1DEd45RlQSiMZcVaJ2xmyQyLJOAVkx13uuWw=;
        b=WS2pbmu4Y3Z2R9gE9W4LbcG9n9PTeHcUiw20hjNyCgFf31mkQZXVFb6eiKosy1bX90
         4/OXMXABBCMgMTPrOXS8ND92XQt0K6bQn3JsU5J1H12K2O0Qqi0h+tmGqbbKNzTomFw2
         G++mwbD5Y1IOtSNbqR0zSgGf+6a0CdhFY7vKS8eN7NaYMFdpSaFYvVl9TOOWqMBcAcjk
         hw/FeXqYVGDLe63svv2HO0pXB4FxtECneohdzi0oP60fvLW8obGHHOVB5YRzAuomVh6j
         xYALfUWfFOaWPQytcvkM0f0nmcXsppP/0KvoFjaP62eUJsPGDFWDHCNvVnVUVo9uNb2n
         dlaA==
X-Received: by 10.50.43.233 with SMTP id z9mr25888957igl.41.1413161795447;
 Sun, 12 Oct 2014 17:56:35 -0700 (PDT)
Received: by 10.107.131.1 with HTTP; Sun, 12 Oct 2014 17:56:05 -0700 (PDT)
In-Reply-To: <1413104974-3861-1-git-send-email-etienne.buira@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 12, 2014 at 4:09 PM, Etienne Buira <etienne.buira@gmail.com> wrote:
> Replace atexit()s calls with cmd_atexit that is atexit() on threaded
> builds, but handles the callbacks list internally for unthreaded builds.

Maybe hide this in git-compat-util.h and "#define atexit(x)
cmd_atexit(x)"? cmd_ is usually for commands' "main" functions. Maybe
rename it to git_atexit().
-- 
Duy
