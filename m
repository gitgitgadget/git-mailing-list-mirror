From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 15/20] init: allow alternate backends to be set for
 new repos
Date: Thu, 04 Feb 2016 15:05:08 -0500
Organization: Twitter
Message-ID: <1454616308.5545.9.camel@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
	 <1452788777-24954-16-git-send-email-dturner@twopensource.com>
	 <CACsJy8DUpOGtZmBr2F2R+8xvzvHOxLc_YOSnF8eQRvHYq15ttA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 21:05:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRQ9X-0002Oc-Kn
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 21:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932910AbcBDUFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 15:05:13 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34520 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756053AbcBDUFL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 15:05:11 -0500
Received: by mail-qg0-f43.google.com with SMTP id u30so51262674qge.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 12:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=RiRh+9JNHpmb8esSxc0io/sGDHnHXaF9Yu7brnU2wQg=;
        b=S/4zfM+CvAGeUmEZMcUsQK5cPhQMW5z7Lmt48l/QJCxnPJaDKmdvIgmCJTy21gXNCE
         0TGDAO2yTwKkONuzoAfKnOe569Z7LufR5r57H9IPJ26iDcxRB+bb2i7I22i3Ms/68yw1
         nDC0TXtRTSG7rEj8+CM+o42If9y9ll1oFu0hruu21VUk5GJoob2lD6BW8z9Ytd6JU5xu
         G4Ii6FA6QV192QTId06Yqha1bR3xlTfFRhTopEYlJc7JdpgpIbRf69BZHW2sILpHqWT0
         itYP1M8sz9rJrmh/RvO//z3C3+Ji/IggoomNm+hzdFOf2JPgjW9TmXMhICSBw1ISCdGK
         KA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=RiRh+9JNHpmb8esSxc0io/sGDHnHXaF9Yu7brnU2wQg=;
        b=aKBCSYYcbznDYYUR0wBOFlzyigMV4f6cHJb46rxCmO34osl4wzr1UTRtJDgYAI2ZRU
         xYs8x819R2z/YNyZ/GuX81VfsYFmSlb5/VdSAIQMDA8bVjz41JfviZ5GZPl7yh+AkJZd
         2R1efOgR+elpK4GWNbMKOZkXnnIDkTZrFihoJANI8srzMGNIZV8a+8ZNHci/h1bGGrem
         AKwLwMgh88ezcR4zKjECOn3b9/ZF34QUJnpCqQkVHTPyCXILK3wFbf+VADQa8tZbT1NN
         xkqJtEU25iMF3nQiGHX7ekAVJOw8ZEUCoe4qiLebKMc/gy9QS4r8KjloePr7Ot7zvR5w
         Ih5g==
X-Gm-Message-State: AG10YOQtyPT4YcbSCCQSikm0WVEVoDzUBHhLDJ5CR7LJLgJMXGrmdpmFTcYDHKLYACT37w==
X-Received: by 10.140.107.182 with SMTP id h51mr11487749qgf.53.1454616310378;
        Thu, 04 Feb 2016 12:05:10 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f5sm5986121qkb.30.2016.02.04.12.05.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Feb 2016 12:05:09 -0800 (PST)
In-Reply-To: <CACsJy8DUpOGtZmBr2F2R+8xvzvHOxLc_YOSnF8eQRvHYq15ttA@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285488>

On Thu, 2016-02-04 at 16:48 +0700, Duy Nguyen wrote:
> (picking a random series version because I didn't follow it closely)
> 
> On Thu, Jan 14, 2016 at 11:26 PM, David Turner <
> dturner@twopensource.com> wrote:
> > +       if (requested_ref_storage_backend)
> > +               ref_storage_backend =
> > requested_ref_storage_backend;
> > +       if (strcmp(ref_storage_backend, "files")) {
> > +               git_config_set("extensions.refStorage",
> > ref_storage_backend);
> > +               git_config_set("core.repositoryformatversion",
> > ref_storage_backend);
> > +#ifdef USE_LIBLMDB
> > +               register_ref_storage_backend(&refs_be_lmdb);
> > +#endif
> > +               set_ref_storage_backend(ref_storage_backend);
> > +               repo_version = 1;
> > +       }
> > +
> > +       if (refs_init_db(&err, shared_repository))
> > +               die("failed to set up refs db: %s", err.buf);
> > +
> 
> I was surprised that "git init --ref-storage=lmdb abc" ran
> successfully even on non-lmdb build. Of course running any commands
> in
> the new repo will fail, suggesting to rebuild with lmdb. But should
> "git init" fail in the first place? I see Thomas' comment about this
> block, but not sure why it still passes for me. It does not catch
> unrecognized backend names either.

This was broken in this patchset and is fixed in the set I've got in
-progress (with a test).

> Also it would be nice if we could hide #ifdef USE_LIBLMDB (here and
> in
> config.c) away, maybe in refs directory. I imagine a new backend
> would
> need the same set of #ifdef. Spreading them across files does not
> sound ideal.

Good point. Moved to a single one in refs.c.  Thanks.
