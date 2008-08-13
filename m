From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-daemon: Simplify child management and associated logging by
Date: Wed, 13 Aug 2008 09:18:37 +0200
Message-ID: <81b0412b0808130018n63c71089u52b95f5a836f35f3@mail.gmail.com>
References: <20080812193613.32388.92145.stgit@aristoteles.cuci.nl>
	 <20080812212534.6871.19377.stgit@aristoteles.cuci.nl>
	 <48A28231.6090105@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Aug 13 09:19:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTAdy-0000gx-2i
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 09:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbYHMHSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 03:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbYHMHSj
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 03:18:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:2378 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbYHMHSj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 03:18:39 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3175127rvb.1
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 00:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Z6ptaJIePo9d365/luUG+i4yA/yyLebb7FSuH2Wpd/g=;
        b=g+8YHY/8ljxowaANS1DobXv/rm3xIN10x4H2Y//7VdZNHBAupTQdMiIyfkPDrmgDAp
         MGzyAw3quA0t4SMICjV3TdF8CRymC8zfTK2V8LXZ3cnx8IrbiD2CZB88gbwOqwJRdtSi
         v3bBYQ0WIKzCaUMlV9PCxgrw1auzzmg/xlBT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ujsBih1/m5Ia5cs5bfL8KfkUzLsf1wM6vNcEf3k1I+l3KdmMzxQLoRldMMDsd/X5Ds
         2DPjyuYa1XE+sDTUYeohdNzfMMUxYllhvI9f4UOACL6krbNQFz5td32I4KqsJSbP1wgh
         M911myxsZE7HTsI6/5j7U4Dbh6sUbyWRdnGbU=
Received: by 10.115.88.1 with SMTP id q1mr5902140wal.122.1218611917557;
        Wed, 13 Aug 2008 00:18:37 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Wed, 13 Aug 2008 00:18:37 -0700 (PDT)
In-Reply-To: <48A28231.6090105@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92187>

2008/8/13 Andreas Ericsson <ae@op5.se>:
> Stephen R. van den Berg wrote:
>>
>> +               /* Since stderr is set to linebuffered mode, the
>> +                * logging of different processes will not overlap
>> +                */
>> +               fprintf(stderr, "[%d] ", (int)getpid());
>> +               vfprintf(stderr, err, params);
>> +               fputc('\n', stderr);
>
> stderr is unbuffered. It's stdout that is linebuffered.
>

Nah, he linebuffered stderr explicitely before.
