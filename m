From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv9 2/6] submodule-config: drop check against NULL
Date: Tue, 9 Feb 2016 13:50:25 -0800
Message-ID: <20160209215025.GH28749@google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
 <1455051274-15256-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 22:50:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTGB6-0006BG-3I
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 22:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933104AbcBIVu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 16:50:28 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33420 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933056AbcBIVu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 16:50:28 -0500
Received: by mail-pf0-f174.google.com with SMTP id q63so397121pfb.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 13:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1BpM79E68NclHNhaVZFDKNX518D5qMgHnf0U9Pas9/o=;
        b=h80qnrwYjtWKZguzF73J4fZQnmS4DnZ7yov1A63LbjEdcmofcCEsKka9pXEw4acHmR
         lNnfLypHitZagsHHgrTroRdWGWiaeseQYMtZxdSRlptvdkVC4VzBVlJvi6pAJmpioIym
         gieYw0QvYKITEQuV+fgD8br9JRBl0w/6Nm5HW+bwjOESXPMxIXuyQRJxfgKZt3tD0Axu
         v5Pv2uRKDKY03ZXdiwoCHKuIJCCWyf1GxKe1Fowz8ST2I0YAmt78f7lfi3cTbrOl1rPU
         naiXlEccIfuPmbPqgbajjues3wgXbcQffiLrJJ9r7fD9Akx7qgd27ZbS26rUTB7g+jUf
         2T4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=1BpM79E68NclHNhaVZFDKNX518D5qMgHnf0U9Pas9/o=;
        b=WSpiLqlUoTPEQGvNF8uspBayitsUxsZfyQvqmi1D6Zp6klmnywjHA6WELNXzTttlhW
         PPtAcb5lJBTBKNR9Pxn2+4l3bhuC5u5mA1eZ3WSiEcCvAJtTdEXkQJAwG5ER41mDNm7H
         +Cn+l7Q6ZnIgzoxovVpXp5CljJwopPza+rfHoDLZNjU4C7YkR5AwdGS1uN1bzAQiXu96
         HgM58xFu0XUJuPOUrABNQIF8IAlBcEqu8j33Wq9wSRsSWo7OtOy6b4uQFu9dZOGSbyL1
         j5+LztbCq/c07/FDFqLEYm0an3xrRvGktEqca6WAlkA314xbxzJcXy04kCtsOu1eB2i7
         4spg==
X-Gm-Message-State: AG10YOQVpQaV+uci6szpd5QNFYc6SbNpsI4Kg2lpVQT/dQFuuQVMbBgZcaZwmWYSv3L+IQ==
X-Received: by 10.98.33.70 with SMTP id h67mr52737374pfh.54.1455054627689;
        Tue, 09 Feb 2016 13:50:27 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:609c:fa:6497:fd10])
        by smtp.gmail.com with ESMTPSA id u5sm47755pfi.15.2016.02.09.13.50.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 09 Feb 2016 13:50:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455051274-15256-3-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285873>

Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule-config.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
