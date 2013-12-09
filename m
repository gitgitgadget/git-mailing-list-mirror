From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Mon, 9 Dec 2013 12:08:20 -0800
Message-ID: <20131209200820.GU29959@google.com>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
 <52A37D70.3090400@gmail.com>
 <87fvq41esw.fsf@thomasrast.ch>
 <52A3A1F5.3080906@gmail.com>
 <87lhzvhceb.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
 <52A5CDB0.2020206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 21:08:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq781-0005fB-6O
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 21:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966Ab3LIUIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 15:08:25 -0500
Received: from mail-qa0-f41.google.com ([209.85.216.41]:44015 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833Ab3LIUIY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 15:08:24 -0500
Received: by mail-qa0-f41.google.com with SMTP id j5so3010686qaq.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 12:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Rn9KaeTMMdO6fkfxD7MuHXidW+4yaRyZ+SEdUyE/RpE=;
        b=I87HSVT8Of1HCDxCeynB/e9PLKq80xvupMRtpVuzbBj19R2TlNtWDDqJawqWxWQgrh
         ewjDLgYkWRZdKxp+gOWvM8u5k0wITMOzopPQCMNemuwS4Guyf8VNsYNDEiSEL8zJfKgv
         +7g9L6DHqcHUY+hanscvrQMZeNpEQUJndaENq0AC0Fv1HNIxa9ausOXDLNmoXt6C7c7u
         cM2oSjJw+ZIRTVv1wrU39VjY+j9BvYsG+BnKsnguCLpZfXbDVgV3eq9M/NwdJoHwMzC+
         0pq75Lx9eekQnHUZVHwkT/TcDCPK9INi8l1qahVvU536DnLocb3RgMSJq1O59MD0iaUj
         iLaw==
X-Received: by 10.49.131.69 with SMTP id ok5mr163498012qeb.77.1386619704007;
        Mon, 09 Dec 2013 12:08:24 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 4sm36830534qak.11.2013.12.09.12.08.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 12:08:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52A5CDB0.2020206@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239085>

Karsten Blees wrote:

> GCC supports __packed__ as of 2.3 (1992), so any other compilers
> that copied the __attribute__ feature probably won't complain.

Alas, it looks like HP C doesn't support __packed__ (not that I
care much about HP C):

 http://h21007.www2.hp.com/portal/download/files/unprot/aCxx/Online_Help/pragmas.htm#Attributes

Maybe a macro expanding to __attribute__((aligned(1))) on the fields
would work?  The same macro could expand to __declspec(align(1)) in
the MSVC build.

Thanks,
Jonathan
