From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] cvsserver: make the output of 'update' more compatible with cvs.
Date: Mon, 07 Dec 2009 11:27:57 +0300
Message-ID: <87ocmbdw8i.fsf@osv.gnss.ru>
References: <87zl5z4y0w.fsf@osv.gnss.ru> <20091205234831.GA925@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: mmogilvi_git@miniinfo.net
X-From: git-owner@vger.kernel.org Mon Dec 07 09:28:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHYwv-0003C1-PM
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 09:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759146AbZLGI1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 03:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759140AbZLGI1x
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 03:27:53 -0500
Received: from javad.com ([205.178.136.214]:42952 "EHLO 02aef2d.netsolvps.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759129AbZLGI1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 03:27:52 -0500
Received: (qmail 23974 invoked from network); 7 Dec 2009 08:27:58 +0000
Received: from unknown (HELO osv.gnss.ru) (89.175.180.246)
  by javad.com with (AES256-SHA encrypted) SMTP; 7 Dec 2009 08:27:58 +0000
Received: from osv by osv.gnss.ru with local (Exim 4.69)
	(envelope-from <osv@osv.gnss.ru>)
	id 1NHYwn-0006kv-4U; Mon, 07 Dec 2009 11:27:57 +0300
In-Reply-To: <20091205234831.GA925@comcast.net> (mmogilvi git's message of "Sat\, 5 Dec 2009 16\:48\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134723>

mmogilvi_git@miniinfo.net writes:

> On Thu, Dec 03, 2009 at 11:12:47PM +0300, Sergei Organov wrote:
>>  
>> +    my $last_dirname = "///";
>> +    
>>      # foreach file specified on the command line ...
>>      foreach my $filename ( @{$state->{args}} )
>>      {
>>          $filename = filecleanup($filename);
>> +        my $cur_dirname = dirname($filename);
>> +        if ( $cur_dirname ne $last_dirname )
>> +        {
>> +            $last_dirname = $cur_dirname;
>> +            if ( $cur_dirname eq "" )
>> +            {
>> +                $cur_dirname = ".";
>> +            }
>> +            print "E cvs update: Updating $cur_dirname\n";
>> +        }
>>  
>>          $log->debug("Processing file $filename");
>
> This should probably be conditional on the absense of the
> global "cvs -q update" and "cvs -Q update" options, in case
> other CVS clients depend on quiet operation when they specify
> those options.

Good catch, thanks! I'll redo the patch.

-- Sergei.
