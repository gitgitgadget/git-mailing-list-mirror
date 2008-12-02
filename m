From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Add a built-in alias for 'stage' to the 'add' command
Date: Tue, 2 Dec 2008 19:36:17 +0700
Message-ID: <fcaeb9bf0812020436n69a21c96g4c13976e493372d9@mail.gmail.com>
References: <20081202061455.GA48848@agadorsparticus>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 13:37:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7UVV-0006N1-Ll
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 13:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbYLBMgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 07:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753467AbYLBMgU
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 07:36:20 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:4548 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330AbYLBMgT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 07:36:19 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2120993fgg.17
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 04:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3nO/KcftkSbxHkNpTLuHzXEsg/tp/Prg1photIuGcAQ=;
        b=bcbeYS8OBb90nzmA1g3SKfilItEBfLkYUHlFJi8RVZK7yg+dnc5ta0URiqtIUqayv2
         m3fpqJ4TqJViiqcjFfxSVisQwYaPSVTA83zWKkrcgSepG2BO8CUgw1H8iVpB5prZGtd8
         82BW7lHzrB2ykvUh8VnNVOdcH4SP3bsAINIy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mfK1pD3i3m4acnP/MDi4hf4xvzS3HRNgkCJmD33x1mVRZt2zqqXUYVK+jYy56Y64kE
         p0CJXijmi4nVVW6frBKa1SL6vu918zyjA4KhorJPCNWwDrzXubPRL+mFc/AkotNcW9nt
         fLefr7nsGWPOus93bv1vuKDQ4YXqXdLNGELo8=
Received: by 10.86.63.19 with SMTP id l19mr7194443fga.40.1228221377400;
        Tue, 02 Dec 2008 04:36:17 -0800 (PST)
Received: by 10.86.62.13 with HTTP; Tue, 2 Dec 2008 04:36:17 -0800 (PST)
In-Reply-To: <20081202061455.GA48848@agadorsparticus>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102130>

On 12/2/08, Scott Chacon <schacon@gmail.com> wrote:
>  diff --git a/git.c b/git.c
>  index 89feb0b..9e5813c 100644
>  --- a/git.c
>  +++ b/git.c
>  @@ -266,6 +266,7 @@ static void handle_internal_command(int argc, const char **argv)
>         const char *cmd = argv[0];
>         static struct cmd_struct commands[] = {
>                 { "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>  +               { "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>                 { "annotate", cmd_annotate, RUN_SETUP },
>                 { "apply", cmd_apply },
>                 { "archive", cmd_archive },

Nit-picking. There are some references to "git add" in builtin-add.c,
like help usage or error message ("Maybe you wanted to say 'git add
.'?\n"). Should it refer to "git stage" instead as well?
-- 
Duy
