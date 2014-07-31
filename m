From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 4/9] index-helper: new daemon for caching index and
 related stuff
Date: Wed, 30 Jul 2014 22:41:36 -0400
Organization: Twitter
Message-ID: <1406774496.4215.3.camel@leckie>
References: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
	 <1406548995-28549-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 04:41:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCgJM-0007tv-Cr
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 04:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781AbaGaClk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jul 2014 22:41:40 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33716 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924AbaGaClj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 22:41:39 -0400
Received: by mail-qg0-f52.google.com with SMTP id f51so2985532qge.25
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 19:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Z0+dncjQmqcL0VJQj33Q8MCAjcRzXyuDI+806KX03Bc=;
        b=Mio+Zb0iCUiL4kc83gm9ECI4WO7YZQQdnRPmJJImszxI7YjLAuXA6ioDJoUsBWoaVj
         S3jaPm25OeTQFPkxhzbZesj9LM8F+lfDSuuQKt2uWVxuz55AwLnOCXpv0M4cgYOQcZoB
         FnwONxpkfqlVhNy9YhNAP52EPCm9id518086dDyZDDKOIZwSdOYvf+urvrnt6Eml5TrE
         /myYcM2ve/HNqn3/MqBOzRzqd/gN1KBwWw+Y4KJULkmkdHHt5VjnIsTMMETbpLoplf4S
         7K7yx9AkrQqzqqu7lmV4NmbWxqMnAO5uvjgSWZac9Hzw5dhfxVtnYLRLslCCBA6coCPA
         1ruQ==
X-Gm-Message-State: ALoCoQndzWXSoePiu5BrpXaiVk3DCjMC7t0iffBzT1JKQoyD6RyOiWsXJW6RiOaejzbN4duTv4l9
X-Received: by 10.140.51.172 with SMTP id u41mr12410887qga.69.1406774498943;
        Wed, 30 Jul 2014 19:41:38 -0700 (PDT)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id 81sm4520064qgw.21.2014.07.30.19.41.37
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 30 Jul 2014 19:41:38 -0700 (PDT)
In-Reply-To: <1406548995-28549-5-git-send-email-pclouds@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254536>


On Mon, 2014-07-28 at 19:03 +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:
> +# Define HAVE_SHM if you platform support shm_* functions in librt.

s/you/your/

> +static void free_index_shm(struct index_shm *is)

Does not actually free its argument; should be release_index_shm. =20
