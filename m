From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 15/20] init: allow alternate backends to be set for
 new repos
Date: Tue, 19 Jan 2016 14:12:28 -0500
Organization: Twitter
Message-ID: <1453230748.16226.36.camel@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
	 <1452788777-24954-16-git-send-email-dturner@twopensource.com>
	 <20160115125139.GI10612@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 20:12:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLbhj-0005CO-1C
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 20:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757282AbcASTMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 14:12:32 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35856 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824AbcASTMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 14:12:30 -0500
Received: by mail-qg0-f50.google.com with SMTP id e32so500154612qgf.3
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 11:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=A/NEPsTXdyHHY3p0sD94GSgc/kuRzopXmjeU5XZ+N8A=;
        b=Y0yScaNdN+xJUtlNBy6p2KkCc5ptsCokaZFLpG/9KO5u6N8Hk+BlaKG+rx6LrvREH7
         ir4Bl/t1A1SPm0IOahvKFX4+2IQDhoiT86LbRrXFsKEB7MxHo55x6RPPMRcwh8KjW1tX
         Hz/Jm7E9COUGE0HAgBWfS+J+TvihTrl7AyvgdgPpJcVGC4CcqKQqBx4XqxkcA++gwiH3
         pFMRg6BXHuIzTaaRvAi+uR0dh9RJJDVV59vGZMxxynhNANRF0MozTuDm9zY4Vyu5FzeL
         EWXKLAyxWXBHaAL1PMXgIlW1CMag2bEs1d4pMOpG34e9weU9zJ5S0zcF74ejaJoem/8+
         PHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=A/NEPsTXdyHHY3p0sD94GSgc/kuRzopXmjeU5XZ+N8A=;
        b=KGQHDNAjDIA7FdmpJ+2KvsbNU0DWhxeSdeyzGBkkOmwZwFp7fdiSY+YVblhItYnsGc
         +UEU7W1A94PRiuaGPF+enw6VnjqcCSTC1JoNp2RJnmFvmJt5VgU5UUBLKStQdDoRVEus
         rUOdApkjs7NvRzVw+7t0uZeLMtXf+6f4sy6tDnM0KeHlu72h5bhN4PXN/ItbiGtnCuvW
         EbxjQzrSZSiCv23URJgEkDXApJnGlXSYHqnf5ps4KSfsV36om+Y/xL/qSZNXglNSbAAF
         aH+bDWV9ZiE7ATgJONo60S4iWf1HUdP4wBMLjdRc+Za1MF/F6pTXeE2eZIpPorZ5Gr6j
         pxCQ==
X-Gm-Message-State: ALoCoQmxDCdMziePldTQ6tDCpxBuedSW+x8rarbuQ4h+0hpXg5Vt6mtxEYf2df1W8iBeNRNHm/ZaQLzDmqg+HtcV3H/e85Vc1w==
X-Received: by 10.140.40.37 with SMTP id w34mr40431991qgw.85.1453230749740;
        Tue, 19 Jan 2016 11:12:29 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id a66sm12801935qkb.20.2016.01.19.11.12.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jan 2016 11:12:28 -0800 (PST)
In-Reply-To: <20160115125139.GI10612@hank>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284373>

On Fri, 2016-01-15 at 13:51 +0100, Thomas Gummerer wrote:
> On 01/14, David Turner wrote:
> > +	if (requested_ref_storage_backend)
> > +		ref_storage_backend =
> > requested_ref_storage_backend;
> > +	if (strcmp(ref_storage_backend, "files")) {
> > +		git_config_set("extensions.refStorage",
> > ref_storage_backend);
> > +		git_config_set("core.repositoryformatversion",
> > ref_storage_backend);
> > +#ifdef USE_LIBLMDB
> > +		register_ref_storage_backend(&refs_be_lmdb);
> 
> refs_be_lmdb is not yet defined at this point in the patch series. 
>  It
> doesn't break anything, because USE_LIBLMDB doesn't leak through the
> makefile yet, but I still think it would make more sense to have the
> ifdef in 19/20.

Thanks, fixed.

> > +#endif
> > +		set_ref_storage_backend(ref_storage_backend);
> 
> More importantly, there is no check whether setting the ref storage
> backend succeeds.  If a user accidentally sets an invalid value for
> the ref backend, a broken repository will be created without even
> warning the user.
> 
> While the repository will still work fine at this point in the
> series,
> git will die with an invalid ref backend in the config after 19/20.
> It can be fixed by setting extensions.refStorage to files in the
> config, because the backend is initialized to the default files
> backend below when the ref backend cannot be set.
> 
> I think it would be best to die() here, if setting the ref backend
> doesn't succeed, and clean up the files that were already written,
> instead of leaving the user with a broken repository.

I've rearranged this code. 

> > +test_expect_success 'init with bogus storage backend fails' '
> > +
> > +	(
> > +		mkdir again2 &&
> > +		cd again2 &&
> > +		git init --ref-storage=test >out2 2>err2
> > +	)
> > +'
> 
> I noticed the above mainly because of this test, which doesn't seem
> to
> test what it claims to test.  It only seems to test that git init
> succeeds, and writes something to out2 and err2, it's missing the
> checks that the contents are actually what they're supposed to be.

Fixed, thanks.
