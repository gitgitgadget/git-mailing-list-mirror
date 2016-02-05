From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv8 2/9] submodule-config: drop check against NULL
Date: Thu, 4 Feb 2016 17:05:09 -0800
Message-ID: <20160205010509.GB19501@google.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
 <1454623776-3347-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 02:05:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRUqP-0006xp-Ui
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 02:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbcBEBFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 20:05:14 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33096 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbcBEBFN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 20:05:13 -0500
Received: by mail-pa0-f52.google.com with SMTP id cy9so24619192pac.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 17:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2UhOqj32sZ3Iqhopb54Q9wORehILJ0Gx8uIV0wB5akw=;
        b=n3MooU5I4LVwkQwGGOEX/432Q/otsqvB493C2dT/T9J1SlxdAcQfar78peODKnqChw
         y+uE5IqdLRpFDLi0hvPt6yiXRGhJMBpyt7xsqEjeU/A28oJAUMOE10Lyn5YjUCJ5JMfG
         xBtHnAg/Ocs9EzzHIEkE3h694jKspVJRPJHHX+pF/2P+mH4M8uZBxRPIlQWqD0zuLIWz
         Ms9eNt5HLfUln82c7FXQaIjqD/H6gyu0GZ2wgjkUZyc6vhYUC0SUPzEjqI4ln5ooPZUr
         zs1wXlmoeJE92CVWoP0x1I5KLicM2pMOeZnh5ZNaAJS3Zb8MHXDD39oC9vPlTGFallZZ
         nA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2UhOqj32sZ3Iqhopb54Q9wORehILJ0Gx8uIV0wB5akw=;
        b=Q/oRjDUiEW/9iWyhrPQPFCl41D9Rqc9ggiUcaw3RwJKKzI5AjBj1nAQI5CQ1aWCJxF
         W6b2W0xDORwu6hj3K3IossGa1YjBYJ+xMHe2c6xq6d4n/sJnDfEZvb6Wf6xq3xRd0mep
         TWtE6gzj6C9Dkz6fS2puLFl3RjEEw1B8U4n//IzoV9+P5588k1etMyuTtFyotDOZh+Pq
         dzE5yAiXrjoG4AhX0Sa3sdHYqi020TgLfFjYTpuX3Z5gU/y+IU/KEfVUJLsIXbDBj9N3
         XUe+BxGGk/wrVW0oSVwtDpXkRWnaA+ui6ehUnDYjMxgrLLtHQgUFwC1Y+0wnYuPkcA69
         +/Cw==
X-Gm-Message-State: AG10YOSBo0WWO7LCNal2tb/icCbj7A2arsai4H4oLuBpNEeQ7YcR1jvgznxIegzWO1NKCg==
X-Received: by 10.66.220.170 with SMTP id px10mr15809739pac.145.1454634312433;
        Thu, 04 Feb 2016 17:05:12 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:13b:4e5f:e68f:7e5b])
        by smtp.gmail.com with ESMTPSA id tp3sm19875474pac.16.2016.02.04.17.05.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Feb 2016 17:05:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1454623776-3347-3-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285534>

Stefan Beller wrote:

> Adhere to the common coding style of Git and not check explicitly
> for NULL throughout the file. There are still other occurrences in the
> code base but that is usually inside of conditions with side effects.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule-config.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Thanks.
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
