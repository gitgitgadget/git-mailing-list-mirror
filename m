From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 36/41] refs.c: move the check for valid refname to
 lock_ref_sha1_basic
Date: Fri, 30 May 2014 11:12:42 -0700
Message-ID: <20140530181242.GJ12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-37-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 30 20:12:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqRIQ-0003mr-0X
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 20:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933196AbaE3SMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 14:12:46 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:37171 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932556AbaE3SMp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 14:12:45 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so1983795pad.9
        for <git@vger.kernel.org>; Fri, 30 May 2014 11:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bVNRQ0W5qnae0iYINSJvTF1PkaALotE8KKcXnRS7Mek=;
        b=LpB7L/8Nc3bSUoZvs2JtcmUTiTQwAKwQHzZCwBTHa9JO3eSMbTtSz9KrgFzYOCV6Xa
         lcUI1BeYJ9lWSLn8w0GKsktq7+oMRMT+hIl9KdyUzMdxz7c5PMmcamtNRdY194uN5SFf
         BbmQSQQXJDuVR/VGWPuTlhEh1b72Z3rJarE78rsOzAiYtU9YDSRWwZlz1sujBdx758JS
         CTIAhrCmn5kr2E6sb9PPh7S9nzf4Fl7ZqD7jJIR+e3dENg6sfX/mYH1IjTlJsbjwRS8Y
         NJtACKpsSY9nSSbVRHT2OAL3VbOCQtpf8XoM3EnntIVGAXH+W/h5VGci593UakmRpovO
         1zbQ==
X-Received: by 10.66.139.201 with SMTP id ra9mr20896198pab.84.1401473564772;
        Fri, 30 May 2014 11:12:44 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qv9sm7470613pbc.71.2014.05.30.11.12.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 May 2014 11:12:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-37-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250458>

Ronnie Sahlberg wrote:

> Move the check for check_refname_format from lock_any_ref_for_update
> to lock_ref_sha1_basic. At some later stage we will get rid of
> lock_any_ref_for_update completely.

Do you know if this will cause any functional change?

What is the potential impact?  Is that impact worth it?  (Given how
broken the recovery codepaths currently are, I suspect this change is
worth it, but it seems worth documenting in the log message.)

Thanks,
Jonathan
