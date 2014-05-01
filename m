From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Define constants for lengths of object names
Date: Thu, 1 May 2014 11:23:04 -0700
Message-ID: <20140501182304.GB9218@google.com>
References: <1398942410-112069-1-git-send-email-sandals@crustytoothpaste.net>
 <20140501172007.GZ9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu May 01 20:23:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfvda-0006ah-L0
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 20:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbaEASXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 14:23:10 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:41030 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaEASXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 14:23:09 -0400
Received: by mail-pa0-f45.google.com with SMTP id kq14so4097803pab.4
        for <git@vger.kernel.org>; Thu, 01 May 2014 11:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=L8VZrAs8vWwgbr3Rv6+81DwEwtb1Mt2OGxXP2qrnhJk=;
        b=vqWOWNhFnidOWj35Yis6ej9dGHsuYQKmVbg5vnGOrfHqpwXWu5E4U2N9svj7hgItah
         DH1lSGqvlJH+S8X3kAsNGLIEpyStM3ix/na1jGN4xMYb6sAZdtloavUoVfW0I1/YX6mh
         0MFsmyQEYavT+iXvHxOamyYZ0pjHRXz4mFoWcmfNKW2E34kHmkb2lhoN8Nv4im8/Mk4l
         Qd6g1rPEitd7uKsc2g7mCL3O5FUs0EvKmT6xBP7FNcxkw5G4qLtVJ8JuCqYecGuJHHAk
         Hqv6HvMPvmnZOePTCrZXxla2ot8Q14DMLdu3V6QzsdOvf1FnWrXWmZsB4E3PGpQeCfBl
         Q6BQ==
X-Received: by 10.66.124.163 with SMTP id mj3mr24226799pab.38.1398968587860;
        Thu, 01 May 2014 11:23:07 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qx11sm163296692pab.35.2014.05.01.11.23.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 01 May 2014 11:23:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140501172007.GZ9218@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247823>

Jonathan Nieder wrote:
> brian m. carlson wrote:

>> --- a/object.h
>> +++ b/object.h
> [...]
>> @@ -49,7 +56,7 @@ struct object {
>>  	unsigned used : 1;
>>  	unsigned type : TYPE_BITS;
>>  	unsigned flags : FLAG_BITS;
>> -	unsigned char sha1[20];
>> +	unsigned char sha1[GIT_OID_RAWSZ];
>
> Maybe my brain has been damaged by reading code from too many C
> projects that hard-code some constants, but I find '20' easier to read
> here.

That said, RAW_SHA1_BYTES would sound okay to me.

Part of the problem was how long it takes to mentally parse oid_rawsz.

Thanks,
Jonathan
