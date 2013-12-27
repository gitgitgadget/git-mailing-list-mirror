From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] git-svn: workaround for a bug in svn serf backend
Date: Fri, 27 Dec 2013 12:07:08 -0800
Message-ID: <20131227200708.GD20443@google.com>
References: <20131226202805.GV20443@google.com>
 <1388131515-3015-1-git-send-email-rkagan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Benjamin Pabst <benjamin.pabst85@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Roman Kagan <rkagan@mail.ru>
X-From: git-owner@vger.kernel.org Fri Dec 27 21:07:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vwdgn-0004Kw-Iv
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 21:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767Ab3L0UHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 15:07:15 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:36305 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652Ab3L0UHN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 15:07:13 -0500
Received: by mail-yh0-f49.google.com with SMTP id z20so2008547yhz.22
        for <git@vger.kernel.org>; Fri, 27 Dec 2013 12:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dY17yvfctaxbRK0M8gO9m3IJ/DHuMhsE8g0diAvO4q4=;
        b=hGp8b1zhPj4Y8VMHeDGS2GvbqUgfFfcCw4OxqsClmDzEWyeBWAvH6KmdmqKd8YHFoX
         lha+57CXRxRRDafX3UJKP4DandfQmRtdOJjr2iXf5gUfEui2b+ftlHYCM+/jcf9YmBUz
         1WPVf867QN32DRpApORawiKR96M+F0b0pFOeNxz65Df+F2aEoPzayMQpQCjxuGS1ZIfP
         3hA+62TEPAy/ua3uZD2iMMOm/ZkwyM3BfLhv1gkjtb6IucGT+e3p/4ojIcweLaKkNLDe
         mPW8sVX4GGkVxuaUgAjsH+xsq3wXrgq0SpboyPT9daX7NaU503pSQuyoNm5Fymg1GI3J
         a82Q==
X-Received: by 10.236.19.77 with SMTP id m53mr367020yhm.143.1388174832015;
        Fri, 27 Dec 2013 12:07:12 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 48sm48009024yhq.11.2013.12.27.12.07.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Dec 2013 12:07:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1388131515-3015-1-git-send-email-rkagan@mail.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239743>

Roman Kagan wrote:

> Subversion serf backend in versions 1.8.5 and below has a bug that the
> function creating the descriptor of a file change -- add_file() --
> doesn't make a copy of its third argument when storing it on the
> returned descriptor.  As a result, by the time this field is used (in
> transactions of file copying or renaming) it may well be released, and
> the memory reused.
>
> One of its possible manifestations is the svn assertion triggering on an
> invalid path, with a message
>
> svn_fspath__skip_ancestor: Assertion `svn_fspath__is_canonical(child_fspath)' failed.
[...]

Makes sense.  Perhaps also worth mentioning that this is fixed by
r1553376, but no need to reroll just for that.

> Cc: Benjamin Pabst <benjamin.pabst85@gmail.com>
> Cc: Eric Wong <normalperson@yhbt.net>
> Cc: Jonathan Nieder <jrnieder@gmail.com>

No need for these lines --- the mail header already keeps track of who
is being cc-ed.

> Signed-off-by: Roman Kagan <rkagan@mail.ru>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
