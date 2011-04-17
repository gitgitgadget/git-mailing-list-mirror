From: madmarcos <fru574@my.utsa.edu>
Subject: Re: Java Inflater problem decompressing packfile
Date: Sat, 16 Apr 2011 17:40:24 -0700 (PDT)
Message-ID: <1303000824677-6280097.post@n2.nabble.com>
References: <1302919505984-6278154.post@n2.nabble.com> <20110416063729.GC28853@sigill.intra.peff.net> <1302963832717-6279028.post@n2.nabble.com> <1302964576373-6279050.post@n2.nabble.com> <1302965899845-6279085.post@n2.nabble.com> <1302969047343-6279183.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 02:40:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBG2R-00006H-A1
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 02:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964Ab1DQAk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 20:40:27 -0400
Received: from sam.nabble.com ([216.139.236.26]:33873 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518Ab1DQAkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 20:40:25 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <fru574@my.utsa.edu>)
	id 1QBG2K-0001GM-M9
	for git@vger.kernel.org; Sat, 16 Apr 2011 17:40:24 -0700
In-Reply-To: <1302969047343-6279183.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171705>

someone on the Java forums asked if I knew that the file was being read
completely before inflating. Well... I just assumed (yes, I know not a good
thing to do).
So here is my readFile code in case you want to see it:

public byte [] readFile(String fileName) {
		byte [] input2 = null;
	    File tempPackInputFile2 = new File(fileName);
		InputStream tempPackInputStream2;
		try {
			tempPackInputStream2 = new FileInputStream(tempPackInputFile2);
			long tempPackLength2 = tempPackInputFile2.length();
			input2 = new byte[(int) tempPackLength2];
			// Read in the bytes
		    int offset2 = 0;
		    int numRead2 = 0;
		    while (offset2 < input2.length
		           && (numRead2 = tempPackInputStream2.read(input2, offset2,
input2.length-offset2)) >= 0) {
		        offset2 += numRead2;
		    }
		    tempPackInputStream2.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	    return input2;
	}

--
View this message in context: http://git.661346.n2.nabble.com/Java-Inflater-problem-decompressing-packfile-tp6278154p6280097.html
Sent from the git mailing list archive at Nabble.com.
