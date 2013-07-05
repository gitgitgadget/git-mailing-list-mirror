From: David Rothenberger <daveroth@acm.org>
Subject: Re: git-svn "Temp file with moniker 'svn_delta' already in use" and
 skelta mode
Date: Fri, 05 Jul 2013 16:07:02 -0700
Message-ID: <51D75196.4030100@acm.org>
References: <kr7beq$ilk$1@ger.gmane.org> <E82AC74E-3294-415D-8E59-97DDD213B11A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: users@subversion.apache.org
X-From: users-return-18595-gcvsu-users=m.gmane.org@subversion.apache.org Sat Jul 06 01:07:41 2013
Return-path: <users-return-18595-gcvsu-users=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsu-users@plane.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by plane.gmane.org with smtp (Exim 4.69)
	(envelope-from <users-return-18595-gcvsu-users=m.gmane.org@subversion.apache.org>)
	id 1UvF6K-0005i7-Tw
	for gcvsu-users@plane.gmane.org; Sat, 06 Jul 2013 01:07:41 +0200
Received: (qmail 90166 invoked by uid 500); 5 Jul 2013 23:07:39 -0000
Mailing-List: contact users-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:users-help@subversion.apache.org>
List-Unsubscribe: <mailto:users-unsubscribe@subversion.apache.org>
List-Post: <mailto:users@subversion.apache.org>
List-Id: <users.subversion.apache.org>
Delivered-To: mailing list users@subversion.apache.org
Received: (qmail 90158 invoked by uid 99); 5 Jul 2013 23:07:39 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Fri, 05 Jul 2013 23:07:39 +0000
X-ASF-Spam-Status: No, hits=-0.0 required=5.0
	tests=RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: domain of gcvsu-users@m.gmane.org designates 80.91.229.3 as permitted sender)
Received: from [80.91.229.3] (HELO plane.gmane.org) (80.91.229.3)
    by apache.org (qpsmtpd/0.29) with ESMTP; Fri, 05 Jul 2013 23:07:33 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvsu-users@m.gmane.org>)
	id 1UvF5r-0005H4-OS
	for users@subversion.apache.org; Sat, 06 Jul 2013 01:07:11 +0200
Received: from c-24-16-16-7.hsd1.wa.comcast.net ([24.16.16.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <users@subversion.apache.org>; Sat, 06 Jul 2013 01:07:11 +0200
Received: from daveroth by c-24-16-16-7.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <users@subversion.apache.org>; Sat, 06 Jul 2013 01:07:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-16-7.hsd1.wa.comcast.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <E82AC74E-3294-415D-8E59-97DDD213B11A@gmail.com>
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229683>

On 7/5/2013 3:58 PM, Kyle McKay wrote:
> On Jul 5, 2013, at 13:48, David Rothenberger wrote:
>> I recently upgraded my Subversion server to 1.8.0 and started
>> receiving the following error from "git svn fetch":
>>
>> Temp file with moniker 'svn_delta' already in use at
>> /usr/lib/perl5/vendor_perl/5.10/Git.pm line 1024.
>>
>> This occurs only when using an http:// URL; svn:// URLs work fine.
> [snip]
>> The client is Cygwin: svn version 1.8.0 and git version
>> 1.8.3.2.
> 
> The subversion 1.8 release has removed the neon library, all svn client
> http access now always goes through the serf library.  If you put
> "http-library = serf" in the "[global]" section of the
> "~/.subversion/servers" file you will get the 'svn_delta' error with
> git-svn when running earlier versions of the svn client as well.

That was not my experience. I did try this with the 1.7 perl bindings
and libraries and with "http-library = serf" in by servers and it worked
fine. I confirmed that serf was being used with a Wireshark trace.

-- 
David Rothenberger  ----  daveroth@acm.org

To downgrade the human mind is bad theology.
                -- C. K. Chesterton
