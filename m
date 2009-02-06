From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCHv2] gitweb: Better regexp for SHA-1 committag match
Date: Fri, 6 Feb 2009 16:47:57 -0500
Message-ID: <76718490902061347h5bc35e7et9e1b66bf9dd2c93a@mail.gmail.com>
References: <200902022204.46651.toralf.foerster@gmx.de>
	 <200902061126.18418.jnareb@gmail.com>
	 <b77c1dce0902060231u358587d5o940eb322fde52a68@mail.gmail.com>
	 <200902061149.16210.jnareb@gmail.com>
	 <alpine.DEB.1.00.0902061403130.7377@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 06 22:49:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVYZf-0007Vt-LI
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 22:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbZBFVsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 16:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753737AbZBFVr6
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 16:47:58 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:20468 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbZBFVr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 16:47:57 -0500
Received: by rv-out-0506.google.com with SMTP id k40so975882rvb.1
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 13:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3JJL/YIP0OjDji0zzqL5On24y5NYFTDBrJrieAbs82k=;
        b=Hrcc5RQMhPPTIvT77KB6vzAqSosjbr4HrZdSFbX45NAK+ALADuAECIUtqYt8nxN+OO
         JMlGNQF5b/Knk/Ixx1Nv1O3HBq8nDXYtwGhNKOZWI1Lozmdhd+RV1xgNaGrUKUZfFRie
         mrN1xFh3cP2exoW+chOBuWFOpfa3KgGKMoXu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fDaD3AniZMygVtHr7Y4KbElUZH2K/KWOZ3h5tEzGLxaGzTWjLPkOkbcMIxt6bhLWNv
         TcbmqGJ+t5D1nDxzx79SgCJX3UClA13Ji4Ufn/gvag5f0Ag3S0ro0KfrfQV9twsSR/a/
         MDpE1ORl0gCYzpo7gmF0YVGb6UG24RyP14O2w=
Received: by 10.141.33.19 with SMTP id l19mr1653493rvj.91.1233956877233; Fri, 
	06 Feb 2009 13:47:57 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902061403130.7377@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108791>

On Fri, Feb 6, 2009 at 8:03 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 6 Feb 2009, Jakub Narebski wrote:
>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index f27dbb6..5dcc108 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -1364,7 +1364,7 @@ sub format_log_line_html {
>>       my $line = shift;
>>
>>       $line = esc_html($line, -nbsp=>1);
>> -     if ($line =~ m/([0-9a-fA-F]{8,40})/) {
>> +     if ($line =~ m/\b([0-9a-fA-F]{8,40})\b(!?\@)/) {
>
> Looks good to me!

I wonder if just matching lower-case a-f would be sufficient as well?

j.
