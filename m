From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: Ignore on commit
Date: Thu, 04 Oct 2012 19:02:34 -0400
Message-ID: <506E158A.2020903@gmail.com>
References: <CAKRNd4w4Z-LS9O5ffkbTSZ0Guv4KCmWR=AtW3EpxQ2sSgazG=Q@mail.gmail.com> <506DEC50.7090402@obry.net> <CAKRNd4wbT_boRyFOOL_95FBW4ws8Zzz2ubVCfXuRSevzPdhW9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: pascal@obry.net, git@vger.kernel.org
To: Marco Craveiro <marco.craveiro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 01:45:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJuRM-0007QC-KC
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 01:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431Ab2JDXCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 19:02:38 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34294 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab2JDXCh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 19:02:37 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2288445iea.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 16:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=PQnqRUtOXQSwyggXNRB0TR5UH0zX89ekXQs6HE5bzag=;
        b=PFsnPh/32mFb127Otr8UDLudETVesRuW9w9fSUX+Jh4Z9fq4A1LwSFULPEXm+g4+AS
         FxfKtrakkvqwrbfjfOT81DjGdcE0e+hPQuf24uL0+xJHJ9KKoNUQ+wH/59cRe07anfC4
         ZjpKyULMlA3eqmNY9z/zA1HAgezIgIiNhNvcSfke7eWdj5dxgqq9iO89gP2pP93Tcleh
         1p6CutR4U+qXN+timD6G6BVILCcjgJAssNcT6J5h9u0U6FRANCeBUlI8yGoaS3kOTyn1
         3dlyBY1rl3vO84eKxBF/rwf9d8EOKW8IhBy3oiUF3g/kom/b5Xgd+S7iOlmGEX1R68et
         QI7w==
Received: by 10.50.41.132 with SMTP id f4mr6892634igl.39.1349391757203;
        Thu, 04 Oct 2012 16:02:37 -0700 (PDT)
Received: from [192.168.1.112] ([66.207.196.114])
        by mx.google.com with ESMTPS id y9sm6874856igm.10.2012.10.04.16.02.35
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 16:02:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <CAKRNd4wbT_boRyFOOL_95FBW4ws8Zzz2ubVCfXuRSevzPdhW9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207055>

On 10/04/2012 05:20 PM, Marco Craveiro wrote:
> Similar but not quite; the idea is that you know that there is some
> code (I'm just talking about files here, so lets ignore hunks for the
> moment) which is normally checked in but for a period of time you want
> it ignored. So you don't want it git ignored but at the same time you
> don't want to see these files in the list of modified files.
The way I usually handle this scenario is by actually making a temporary 
commit with those temporary changes. And whenever I make a permanent 
commit, I'll use "rebase -i" to rearrange the commits so that all my 
permanent commits go before my temporary commits. So when I need to 
push, I'll just push up till before my temporary commits.

This way I also get to make permanent changes in files that I have 
temporary changes.
