From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v4 13/14] builtin/update-index.c: cleanup update_one
Date: Fri, 08 Nov 2013 11:27:34 +0100
Message-ID: <527CBC96.2090101@gmail.com>
References: <527BA483.6040803@gmail.com> <527BA738.9000104@gmail.com> <xmqqwqkjq49v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 08 11:27:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VejI2-0004P2-1L
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 11:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757152Ab3KHK1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 05:27:38 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35993 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757122Ab3KHK1d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 05:27:33 -0500
Received: by mail-wi0-f173.google.com with SMTP id ey11so1923221wid.12
        for <git@vger.kernel.org>; Fri, 08 Nov 2013 02:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=OL0y+8IrubHqikXX74TS09Z3i/ZLiI/yv3dWDSJqgS8=;
        b=ZnBBdIT7RUITOuXozloTs7L9bwIXk55atii0YImqOcGPXyntnxGgs8iUqSrQbT1jgf
         347FYH1DLCFYsAzhuP04uMuWqdpVLPIuiV4vUwSVS1xMRGcIU5uikfo16wfk0BCx51d4
         s3o90zXvIxDZBsTIg0vfWyUCrQrh7ivIGRioBRBAkVP6utlBQGepY+DUhXPjxEmdY9B+
         bN+XGV3mmoY6X5ZChU3qQp5yPbOS31oknnjv1X+xcLRPDwdbUKKW7u476mkrcVSpoT1f
         e/JtTDl8EMBTS5Kx7GaQ6mRKCnDmVEQkvSKY775x8LY40ighrilCytFff/ZHfXXOW7dg
         gkXA==
X-Received: by 10.194.187.232 with SMTP id fv8mr523436wjc.56.1383906452607;
        Fri, 08 Nov 2013 02:27:32 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id q3sm4159732wib.5.2013.11.08.02.27.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 08 Nov 2013 02:27:32 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqwqkjq49v.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237450>

Am 07.11.2013 22:40, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> -			if (p < path || p > path + strlen(path))
>> -				free((char *)p);
>> +			free(p);
> 
> The non-const cast was there for a reason.  I'll locally fix it up
> (there is another instance of the same) to get it compile before
> queuing it on 'pu'.
> 
> Thanks.
> 

Seems I spent too much time on code analysis and valgrind results that I missed the compiler warnings...didn't we have -Werror once?
