From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 2/9] test: add test_write_lines helper
Date: Thu, 24 Apr 2014 10:08:26 -0700
Message-ID: <20140424170826.GH15516@google.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
 <1398331809-11309-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
	gitster@pobox.com
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 19:08:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdN8Z-00066h-IT
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 19:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbaDXRId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 13:08:33 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:45764 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932348AbaDXRIa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 13:08:30 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so2174506pbc.15
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 10:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X6CO9356XrNXGLNFaA61eovug1oytrE+0LWpg0/0esg=;
        b=RHIP+ay0v7A9GmDFJm3tMVsNxg2M26PL8qCthSfBIqypdPGWEawQzYPYToRWExgJCx
         hAt4BWirnatCZlGMQOhiEYJpW39z26KsWPI/9tFmHm5d6PT9599YCvxDvY/YhCCUvYPh
         RZHx54vM7HkeJgjYyipamaIquGqzwUOLKfExnEu8U7DY7nBNcdON5IvgJx1dzb8JegA8
         GHnGtMPMb3wF4Vfe0NfY/ia9eIz7RNm414hzne6xea11xnsVkJ+a/KCMmxy0Nu+2piR9
         iOw8oGxl2d2tveuNAaVD/JASPiZK7u/XNqJjXupLdKtd3SVyU4VeUl35Cs/TytbN9FKU
         dm3w==
X-Received: by 10.68.227.4 with SMTP id rw4mr4943311pbc.3.1398359310073;
        Thu, 24 Apr 2014 10:08:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xk1sm23269996pac.21.2014.04.24.10.08.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Apr 2014 10:08:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398331809-11309-2-git-send-email-mst@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246976>

Michael S. Tsirkin wrote:

> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -712,6 +712,11 @@ test_ln_s_add () {
>  	fi
>  }
>  
> +# This function writes out its parameters, one per line
> +test_write_lines () {
> +	printf "%s\n" "$@";
> +}
> +

Thanks for fixing this.

Nits:

 * no need for the trailing semicolon
 * it's probably worth documenting this in t/README as well so people
   writing new test scripts know what it's about.

Thanks,
Jonathan
