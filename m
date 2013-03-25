From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] checkout: add --sparse for restoring files in sparse
 checkout mode
Date: Mon, 25 Mar 2013 08:34:52 +0700
Message-ID: <CACsJy8ByH8U0wYuaKaMKd3bauLBbS52peMs1eiGz++2vj2JKTA@mail.gmail.com>
References: <514C3249.7000100@ivt.baug.ethz.ch> <1364101583-6035-1-git-send-email-pclouds@gmail.com>
 <20130324181752.GA4543@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, kirill.mueller@ivt.baug.ethz.ch
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 02:36:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJwKn-0007Jh-8L
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 02:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756704Ab3CYBf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 21:35:56 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:47396 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756475Ab3CYBfX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 21:35:23 -0400
Received: by mail-ob0-f176.google.com with SMTP id er7so1929381obc.7
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 18:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=cQGe1grWp2uvUadiGru0Rqg56bwyg9gmM/71A+XVfYA=;
        b=uxULBIW4eCo2rbYlhXqnibA7dfQNA/YxqELqWvNjZ4Zm0NG8ORIShX/rR4fV+YEoM+
         6hYUTpQoMaHaKOpL8QZjVHH/1is2v9PP8G2OqyBPAO5Wt4sPLxiR8h6cS2ZM31Vx1//i
         X2RZh//V6YqO2mUSsdAvd7LPDba4Quhnjkd9pH1rHAUWRmNFCU/Gzew6GOcoG/0rQiP2
         4to1h/CTuk78y7bEVvbb9BXIwXOaR/ZliHCjSkmPOaiBZsvcMlygvA/GOrxni9guYLfM
         T6yKl+m6qFaA+kG6HzlJqKEn0G8kkdvVufk0HU+bqkPqs1nXquohtnEHxMVpRqdkxO7w
         hJYg==
X-Received: by 10.60.13.39 with SMTP id e7mr9215798oec.74.1364175322319; Sun,
 24 Mar 2013 18:35:22 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Sun, 24 Mar 2013 18:34:52 -0700 (PDT)
In-Reply-To: <20130324181752.GA4543@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219003>

On Mon, Mar 25, 2013 at 1:17 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> +--sparse::
>> +     In sparse checkout mode, `git checkout -- <paths>` would
>> +     update all entries matched by <paths> regardless sparse
>> +     patterns. This option only updates entries matched by <paths>
>> +     and sparse patterns.
>
> Hm, should this be the default?
>
> In principle, I would expect
>
>         git checkout -- .
>
> to make the worktree match the index, respecting the sparse checkout.
> And something like
>
>         git checkout --widen -- .
>
> to change the sparse checkout pattern.  But of course it is easily
> possible that I am missing some details of how sparse checkout is
> used in practice.
>
> What do you think?

Changing the default may involve a painful transition phase (e.g. "add
-u"). I think making it the default via alias should be good enough in
most cases. We also need to think how it impacts checkout usage in
scripts. I think it might be ok, but I haven't finished my morning
coffee yet, so..
-- 
Duy
