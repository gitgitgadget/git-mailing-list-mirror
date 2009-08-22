From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH v2 05/14] Change regerror() definition from K&R
 style to  ANSI C (C89)
Date: Sat, 22 Aug 2009 08:15:32 +0800
Message-ID: <1976ea660908211715u5dd20fb6vccc5ed94c07e9b3@mail.gmail.com>
References: <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com> <0123e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Aug 22 02:15:46 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-iw0-f142.google.com ([209.85.223.142])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeeGo-00061D-Ba
	for gcvm-msysgit@m.gmane.org; Sat, 22 Aug 2009 02:15:46 +0200
Received: by iwn6 with SMTP id 6so927780iwn.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 21 Aug 2009 17:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=zIESr8JrYbHzZG1V9VRb5ukRZO+Pwr/29vbXzAZvLSM=;
        b=SIhlk2YmEKwk6aW527KjEpI9PsZVVZxdYiK6wNBf63Uz6CcW7wCvgiZjwiPkY9c02E
         /AoO5yKZgA9QVx2v+D4fe/B9TTK1suemxBPfh3ZGbBy1cergJ8uoi7WioyLgRB9xLDVP
         cEMjYFUuOB208JEaC8eLOeC9yiyMsUw9VI3/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=rugHzX4YlgYo9Jp3MWHO/pERuBnijFq6ZFaVTEJA6SCv7v0A8+YV8T7tn8pkuUnvsx
         RDWw5PMaQFClnH4q4QT3mXMOXVeWEaQ0MPIV7NWjj4qTTpc37efAsI0jm+3z/s7kzAFk
         rLjU1FkbCEUi2lea95JLVWLo/BfdblNAteKbA=
Received: by 10.220.43.10 with SMTP id u10mr649084vce.22.1250900139463;
        Fri, 21 Aug 2009 17:15:39 -0700 (PDT)
Received: by 10.230.6.197 with SMTP id a5gr6692vba.0;
	Fri, 21 Aug 2009 17:15:34 -0700 (PDT)
X-Sender: lznuaa@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.220.16.135 with SMTP id o7mr724543vca.21.1250900133273; Fri, 21 Aug 2009 17:15:33 -0700 (PDT)
Received: by 10.220.16.135 with SMTP id o7mr724542vca.21.1250900133257; Fri, 21 Aug 2009 17:15:33 -0700 (PDT)
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24]) by gmr-mx.google.com with ESMTP id 22si244986vws.6.2009.08.21.17.15.32; Fri, 21 Aug 2009 17:15:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of lznuaa@gmail.com designates 74.125.92.24 as permitted sender) client-ip=74.125.92.24;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of lznuaa@gmail.com designates 74.125.92.24 as permitted sender) smtp.mail=lznuaa@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by qw-out-2122.google.com with SMTP id 9so844322qwb.49 for <msysgit@googlegroups.com>; Fri, 21 Aug 2009 17:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type :content-transfer-encoding; bh=k/xSXdtTe5PW90ZGMKNGHgopHfd+JWydaEklbVU2VyQ=; b=tE53iJLbL/pQEfscMqCeJrksifta5V/QARH13hAb6T6Ka63ZcxH7yi/6M9irUiSI0N ONMvATTLsZEIFRNd2mm6B4DfMlljGZJeB4NrASlw7nAiH5Tnhwuofy6Lz9Lrrlului85 VatIGsWg95fY0eZicESNhn8pWL73tKRpo3jlU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type:content-transfer-encoding; b=ncmn/VyY9alZTtv3w2T+0R1wOfAn3l8BM3spzpO9ucI+05IlVrZZqdcbTzx4mL6fdI kVqa9Oa8wqLlftkawJGJP8vU5RitRcNcijUhgrbD2vwwvFJjnVh2LdW3PScx0wDXSc1v IMlEZOxRhsVxuAIJ9GpDfqZQAJKtwml5CPmDg=
Received: by 10.224.106.207 with SMTP id y15mr1307689qao.14.1250900132128;  Fri, 21 Aug 2009 17:15:32 -0700 (PDT)
In-Reply-To: <0123e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126774>


> The MSVC headers typedef errcode as int, and thus confused the
> compiler in the K&R style definition. ANSI style deconfuses it.
>
It is better
best regards
Frank Li
