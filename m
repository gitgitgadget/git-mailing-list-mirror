From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 04/42] refs.c: make ref_update_reject_duplicates take
 a strbuf argument for errors
Date: Tue, 13 May 2014 17:04:02 -0700
Message-ID: <20140514000402.GZ9218@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
 <1398976662-6962-5-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 14 02:04:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkMg8-0001MT-Qk
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 02:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbaENAEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 20:04:09 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:39647 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbaENAEG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 20:04:06 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so883229pad.37
        for <git@vger.kernel.org>; Tue, 13 May 2014 17:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=i8idEmj9kUgp4xQu/AjgBUYryJISiiiFtnbvCv9LEe0=;
        b=J4rrV7QhZ2cC87AsCm9HSCzjAL7c/IfcQLstRQavDTrcdd3AFdWqLAOo9oy+Sj7YWM
         AVlaXwjuRPWSSHwWiWJ51G+SI/wtfmKsASPDMyoWeuoKMcZZQc0ritLhpKJPAD9GH4Ct
         51C+mOLMKxEp/5Vfpj6lr6Nsc9DjuugnRVtC28lgJlS4OzdDH84S+3C5JMRP3zNoNaUw
         yVvwejTLt4Byld4JYEpwWDP8cpR9ChictNqzLgd/YWaRfHZvcN1ThB3NTtRn2mr6Zq7O
         UCp4nxIYnUMuP7ixe2vDXQwSuIfDeTpK5Z8/BQQpUtrBOTKSLFzyIVRCfJ0IlYXNRevt
         RojQ==
X-Received: by 10.66.102.39 with SMTP id fl7mr136771pab.43.1400025845026;
        Tue, 13 May 2014 17:04:05 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id oa3sm134505pbb.15.2014.05.13.17.04.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 May 2014 17:04:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398976662-6962-5-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248892>

Ronnie Sahlberg wrote:

> Make ref_update_reject_duplicates return any error that occurs through a
> new strbuf argument.

Sensible.  The caller-visible effect would be that now
ref_transaction_commit() can pass back a helpful error message through
its "err" argument when asked to make multiple updates for the same
ref.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
