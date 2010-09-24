From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 03/24] t9300 (fast-import): guard "export large marks"
 test setup
Date: Fri, 24 Sep 2010 16:04:55 +0530
Message-ID: <20100924103452.GI22658@kytes>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino>
 <20100924065900.GA4666@burratino>
 <20100924070950.GD4666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 12:36:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz5dz-0000ke-D8
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 12:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250Ab0IXKgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 06:36:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64759 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab0IXKgO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 06:36:14 -0400
Received: by pzk34 with SMTP id 34so564801pzk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 03:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tELozdGXzDUp4l/sUIpYjB39Y6xe/mG4zI6KlKAydIg=;
        b=DnLw5j5UTSy3qQjbK6nx0Dr7W2vWxcuV5YDY2mdfhmnOQyOXo9aj97dllVxHNmxlep
         lXsSJLPUUp4bIVL6rFVOSK5XPKCrX84mBJWyAaRVeAteTUyt/09XumtjkB85fmEnhnx/
         V/vYSqRFJuuLjRfSdZ78f46BZzI3tIQDmW/1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=B8oZwKfzWncGfWr8Woiuh5KjpxHAMM6nDC7Y5p4XIrLM+V8HY2LeLmj0DTlPt6q0s1
         hS1F5MFU89drzAIfQ1xO4tGjBVS3ubikUh03eHi4TsKlI2zFmuqwBPNgcabBQh3ndUyT
         J8pD/WslWuMGINiwk1QEufmBIZu7Mb3jvgjFw=
Received: by 10.114.173.5 with SMTP id v5mr3295785wae.79.1285324574288;
        Fri, 24 Sep 2010 03:36:14 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id s5sm3296063wak.0.2010.09.24.03.36.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 03:36:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924070950.GD4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156970>

Hi again,

Jonathan Nieder writes:
>  test_expect_success 'A: export marks with large values' '
> +	test_tick &&
> +	mt=$(git hash-object --stdin </dev/null) &&
> +	>input.blob &&
> +	>marks.exp &&
> +	>tree.exp &&
> +
> +	cat >input.commit <<-EOF &&
> +	commit refs/heads/verify--dump-marks

Nit: Maybe change this to verify--export-marks corresponding to the
`--export-marks` feature of fast-import? The ref for testing the
`--import-marks` feature is already called `verify--import-marks`.

-- Ram
