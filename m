From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 12:21:30 +0200
Message-ID: <dbfc82860710170321l458ebd1cr6bf619cef9bb7300@mail.gmail.com>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
	 <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu>
	 <3awb7zw6.fsf@blue.sea.net>
	 <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
	 <1192565900.6430.16.camel@athena>
	 <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
	 <20071017015109.303760cc@localhost.localdomain>
	 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
	 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
	 <E29971BA-7306-4570-8383-26D0C9C0B814@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Luke Lu" <git@vicaya.com>, git@vger.kernel.org
To: "Michael Witten" <mfwitten@mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 17 12:21:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii622-00056y-9B
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 12:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758084AbXJQKVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 06:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757988AbXJQKVc
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 06:21:32 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:23775 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757919AbXJQKVb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 06:21:31 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1697911rvb
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 03:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=rLVP520Gews2j8ACB2E8bi0dIxRLD8mrKZImyaBlSrg=;
        b=d5eT3BkUkr1puxur74PIfwGBDu3UlVLA0cuoPAVqgWNQ/kG1hw/Qh/Ozb2bJ5anI+yWPFGdQp15S45Hfyb/W3DJ5rn6BWA+aOYxKhsYRMDSmf2aoN2icyx91ta3UGgvx5Din32iMAEx0ELtYC48q5vCaXX4htzAWLk+m/x2+M4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=j8qGDCcgM7x6755B9wu+KbJgvT+cApNDhtdVkJIwwqE95aidfDS2hL2LtSBrmITgutFQUxFccn+PothahRqmRhMknXfD4ZQGVYUjAZZIvuBiPcVbWl7eei0sIHn0nKbRu2Qo6UHPds3RtQWtn+DP97sYGzLBxgZirtid+G99aKM=
Received: by 10.114.13.1 with SMTP id 1mr9655478wam.1192616490256;
        Wed, 17 Oct 2007 03:21:30 -0700 (PDT)
Received: by 10.114.196.8 with HTTP; Wed, 17 Oct 2007 03:21:30 -0700 (PDT)
In-Reply-To: <E29971BA-7306-4570-8383-26D0C9C0B814@mit.edu>
Content-Disposition: inline
X-Google-Sender-Auth: c5c9b97d449a88a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61362>

On 10/17/07, Michael Witten <mfwitten@mit.edu> wrote:
>
> On 17 Oct 2007, at 3:17:08 AM, Luke Lu wrote:
>
> > But I still haven't seen any compelling arguments against the "all
> > space" case
>
> Overhead!
>
> If you use 8 spaces instead of one tab,
> that's using up 7x more space!
>
> Consider:
>
>      # calculates the extra space required to
>      # use the given number of spaces/tab.
>      size()
>      {
>          count=`grep -RIo "\`printf \"\t\"\`" . | wc -l`;
>          perl -e "print $count*$(($1-1))/1024/1024 . \" MB\n\"";
>      }
>
>      Then in in a git working tree:
>
>          size 8; # 1.28701210021973 MB
>          size 4; # 0.551576614379883 MB
>
>      In a linux kernel working tree:
>
>          size 8; # 61.4902725219727 MB
>          size 4; # 26.3529739379883 MB

As already pointed out, this isn't the true waste.  Run the following
Ruby script to determine the true waste:

------------ cut here -----------
TabWidth = 8

actual_size = 0
expanded_size = 0
ARGF.each_line do |line|
  width = 0
  line.each_byte do |byte|
    width += (byte == ?\t) ? (TabWidth - (width % TabWidth)) : 1
  end
  actual_size += line.length
  expanded_size += width
end
puts (expanded_size - actual_size).to_s
------------ cut here -----------

This will give you the actual space waste.  Run it like so:

% ruby space-waste.rb /usr/src/linux/**/*.[ch]

(or in a similar manner that doesn't fail due to going over the
maximum command-line limit).

According to this calculation the waste is 47808782 bytes, or about
45.6 MiB, for 8-spaces-wide tabs.
